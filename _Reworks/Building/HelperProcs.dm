var/list/CARDINAL_DIRECTIONS = list(NORTH, SOUTH, EAST, WEST)
var/list/ORDINAL_DIRECTIONS = list(NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)

proc/TurfSquare(x1, y1, x2, y2, z, hollow = 0)
	if(x1 > x2) {.=x1; x1=x2; x2=.}
	if(y1 > y2) {.=y1; y1=y2; y2=.}
	if(hollow)
		if(y2-y1<=1 || x2-x1<=1)
			. = block(locate(x1,y1,z),locate(x2,y2,z))
		else
			. = block(locate(x1,y1,z),locate(x1,y2,z)) + block(locate(x2,y1,z),locate(x2,y2,z)) \
							+ block(locate(x1+1,y1,z),locate(x2-1,y1,z)) + block(locate(x1+1,y2,z),locate(x2-1,y2,z))
	else
		. = PlaneBlock(x1, y1, z, x2, y2)

//This function comes from Lummox JR and is only slightly modified to include the mob related checks
proc/TurfEllipse(x1, y1, x2, y2, z, filled, mob/M)
	// sanitize inputs so x1 <= x2 and y1 <= y2
	if(x1 > x2) {.=x1; x1=x2; x2=.}
	if(y1 > y2) {.=y1; y1=y2; y2=.}
	. = list()
	var/_x	// temp var used for looping through coords later
	// x, y, a, and b are all in half-pixel units
	// (x/a)**2 + (y/b)**2 = 1
	// (b*x)**2 + (a*y)**2 = (a*b)^2
	// To add a little wiggle room:
	// (b*x)**2 + (a*y)**2 <= ((a+1)*(b+1))^2
	var/a=x2-x1, b=y2-y1, x=a*b, y=(b&1)*a
	var/absq = (a+1)*(a+1)*(b+1)*(b+1) - x*x - y*y	// we want this to be >= 0 but as small as possible
	// start in middle row(s) and move outward
	_x = round(b/2)	// only using _x as a temp var here
	y1 += _x; y2 -= _x
	while(x >= 0)
		// move outward by a row; this will increase the y**2 term in absq and make it more negative
		// y**2 becomes (y+2a)**2 and we need to add 4ay+4a**2 to the y**2 term
		absq -= 4*a*(y+a)
		y += 2*a
		var/dx = 0	// real-x change for next step
		// if absq is negative we're too far outside of the ellipse, so move a column inward at a time
		while(absq < 0 && x >= 0)
			++dx
			// x**2 becomes (x-2b)**2 so we need to add 4b**2-4bx to the x**2 term
			absq -= 4*b*(b-x)
			x -= 2*b
		if(filled || x < 0)	// x < 0 is the last row of the ellipse
			if(y1 != y2)
				for(_x in x1 to x2)
					var/turf/toCheck = locate(_x, y1, z)
					if(toCheck.CanBuildOver(M))
						. += toCheck
						M.client.AddHighlight(toCheck)
					toCheck = locate(_x, y2, z)
					if(toCheck.CanBuildOver(M))
						. += toCheck
						M.client.AddHighlight(toCheck)
			else
				for(_x in x1 to x2)
					var/turf/toCheck = locate(_x, y1, z)
					if(toCheck.CanBuildOver(M))
						. += toCheck
						M.client.AddHighlight(toCheck)
		else	// non-filled case
			if(y1 != y2)
				for(_x in x1 to x1+dx)
					var/turf/toCheck = locate(_x, y1, z)
					if(toCheck.CanBuildOver(M))
						. += toCheck
						M.client.AddHighlight(toCheck)
					toCheck = locate(_x, y2, z)
					if(toCheck.CanBuildOver(M))
						. += toCheck
						M.client.AddHighlight(toCheck)
				for(_x in x2-dx to x2)
					var/turf/toCheck = locate(_x, y1, z)
					if(toCheck.CanBuildOver(M))
						. += toCheck
						M.client.AddHighlight(toCheck)
					toCheck = locate(_x, y2, z)
					if(toCheck.CanBuildOver(M))
						. += toCheck
						M.client.AddHighlight(toCheck)
			else
				for(_x in x1 to x1+dx)
					var/turf/toCheck = locate(_x, y1, z)
					if(toCheck.CanBuildOver(M))
						. += toCheck
						M.client.AddHighlight(toCheck)
				for(_x in x2-dx to x2)
					var/turf/toCheck = locate(_x, y1, z)
					if(toCheck.CanBuildOver(M))
						. += toCheck
						M.client.AddHighlight(toCheck)
		x1 += dx; x2 -= dx; --y1; ++y2

proc/PlaneBlock(x1, y1, z, x2, y2)
	return block(locate(x1, y1, z), locate(x2, y2, z))

proc/TurfLine(x1, y1, x2, y2, z = 1, mob/M)
	. = list()
	var/list/plots = Math.PlotLine(x1, y1, x2, y2)
	for(var/simple_vector/v in plots)
		var/turf/T = locate(v.x, v.y, z)
		if(T.CanBuildOver(M))
			M.client.AddHighlight(T)
			. += T

proc/TurfFloodFill(turf/origin, range = 20, mob/M)
	set background = TRUE
	. = list()
	var/list/turfsToTry = list(origin)
	while(turfsToTry.len)
		var/turf/current = turfsToTry[1]
		turfsToTry.Cut(1, 2)
		if(ValidFillTurf(current, origin, ., M) && get_dist(current, origin) <= range)
			.[current] = TRUE
			M.client.AddHighlight(current)
			for(var/checkDir in CARDINAL_DIRECTIONS)
				turfsToTry.Add(get_step(current, checkDir))

proc/TurfSpanFill(turf/origin, range = 20, mob/M)
	set background = TRUE
	. = list()
	var/list/turfsToTry = list(origin)
	while(turfsToTry.len)
		var/turf/current = turfsToTry[1]
		turfsToTry.Cut(1, 2)
		var/lx = current.x, rx = current.x
		var/turf/checking = current
		while(ValidFillTurf(checking, origin, ., M) && get_dist(checking, origin) <= range)
			lx = checking.x
			.[checking] = TRUE
			M.client.AddHighlight(checking)
			turfsToTry.Add(checking)
			checking = get_step(checking, WEST)
		checking = get_step(current, EAST)
		while(ValidFillTurf(checking, origin, ., M) && get_dist(checking, origin) <= range)
			rx = checking.x
			.[checking] = TRUE
			M.client.AddHighlight(checking)
			turfsToTry.Add(checking)
			checking = get_step(checking, EAST)
		checking = get_step(current, NORTH)
		for(var/x in lx to rx)
			if(ValidFillTurf(checking, origin, ., M) && get_dist(checking, origin) <= range)
				turfsToTry.Add(checking)
		checking = get_step(current, SOUTH)
		for(var/x in lx to rx)
			if(ValidFillTurf(checking, origin, ., M) && get_dist(checking, origin) <= range)
				turfsToTry.Add(checking)

proc/ValidFillTurf(turf/current, turf/origin, list/selectedTurfs, mob/M)
	return current && isturf(current) && !(current in selectedTurfs) && origin ~= current && current.CanBuildOver(M)

turf/proc/operator~=(turf/T)
	if(isturf(T))
		return T.name == src.name && T.icon == src.icon && T.type == src.type

turf/proc/DecideTurfStateForSpecialIcons(width = 4, height = 4)
	set waitfor = 0
	set background = 1
	var/X = x % width //if 4, 1 = 1, 2 = 2, 3 = 3, 4 = 0, 5 = 1, 6 = 2, etc
	var/Y = y % height
	//becase 4 % 4 = 0 but we need it to be 4
	if(X == 0) X = width
	if(Y == 0) Y = height
	//because the icon's states are 0-3 not 1-4
	X -= 1
	Y -= 1
	icon_state = "[X],[Y]"

atom/proc/base_loc()
	var/turf/t = src
	var/tries = 5
	while(t && !isturf(t))
		t = t.loc
		tries--
		if(!tries) break
	if(!isturf(t)) return null
	return t

proc/viewable(mob/a, mob/b, max_dist = 5000, seePastDenseObjs = 1)
	if(seePastDenseObjs) return b in range(a, max_dist)
	else return b in view(a, max_dist)
	return (a && a.z) && (b && b.z) && (a.z == b.z) && (getdist(a,b) <= max_dist) && (a != b) && (seePastDenseObjs ? (b in orange(a, max_dist)) : (b in oview(a, max_dist)))
	if(!a.z || !b.z || a.z != b.z) return
	a = a.base_loc()
	b = b.base_loc()
	if(a == b) return 1
	if(getdist(a,b) > max_dist) return
	var/turf/t = a

	while(t && t != b)
		max_dist--
		if(!max_dist) return 1
		t = get_step(t,get_dir(t,b))
		if(!t || t.opacity) return //was break
		else for(var/obj/o in t)
			if(o.opacity) return //was break
			if(!seePastDenseObjs && o.density) return
		sleep(0)

	if(!t || t != b) return
	return 1

proc/getdist(atom/a,atom/b)
	if(!a||!b) return
	return max(abs(a.x-b.x),abs(a.y-b.y))

proc/Circle(n = 5, mob/m, viewable_only = 0) //circular ring
	if(!m) return
	var/list/l=new
	//for(var/turf/t in view(n,m))
	var/start = locate(m.x - n, m.y - n, m.z)
	var/end = locate(m.x + n, m.y + n, m.z)
	for(var/turf/t in block(start, end))
		if(sqrt((t.x - m.x)**2 + (t.y - m.y)**2) < n)
			if(!viewable_only || viewable(m, t, max_dist = get_dist(m,t)))
				l += t
	return l

proc/CenterIcon(obj/O,Icon,x_only)
	set waitfor = FALSE
	set background = TRUE
	if(!O) return
	if(!Icon) Icon=O.icon
	O.pixel_x = Icon_Center_X(Icon)
	if(!x_only) O.pixel_y = Icon_Center_Y(Icon)

proc/CenterBounds(obj/O,icon/I,x_only)
	if(!O) return
	if(!I) I = icon(O.icon)
	O.bound_x = Icon_Center_X(I)
	O.bound_width = I.Width()
	if(!x_only)
		O.bound_y = Icon_Center_Y(I)
		O.bound_height = I.Height()

proc/Icon_Center_X(O)
	var/icon/I=new(O)
	return -((I.Width()-TILE_WIDTH)*0.5)

proc/Icon_Center_Y(O)
	var/icon/I=new(O)
	return -((I.Height()-TILE_HEIGHT)*0.5)

proc/Scaled_Icon(O,X,Y)
	var/icon/I=new(O)
	if(X && Y) I.Scale(X,Y)
	return I

proc/GetWidth(O)
	var/icon/I=new(O)
	return I.Width()

proc/GetHeight(O)
	var/icon/I=new(O)
	return I.Height()

// This library handles a lot of common mathematical functions, such as interpolation,
// as well as providing some constant values for commonly used numbers such as Pi.

var/global/math/Math = new
var/global/math/int/MathI = new

math/int
	HandleOutput(x)
		return round(x)

math
	var/const
		E = 2.718281828
		PI = 3.141592653
		HYPOT = 1.414213562

	proc
		// Take the output from the procs and handle it in some way-- for overriding in subclasses.
		HandleOutput(x)
			return x

		// Linear Interpolation between two points.  Where `a` is the starting point, `b` is the end point, and `t` is a number from 0 to 1 (inclusive)
		// indicating how far between the two points the new value is.
		Lerp(a, b, t)
			return HandleOutput(a+(b-a)*t)

		//Cosine Interpolation between two points.  Where `a` is the starting point, `b` is the end point, and `t` is a number from 0 to 1 (inclusive)
		//indicating how far between the two points the new value is.
		Cerp(a, b, t)
			var/f = (1-cos(t*PI)) * 0.5
			return HandleOutput(a*(1-f)+b*f)

		//Bias function to provide a y coord on a 2D grid, based on X.  If bias is 0, y = x.  Closer to 1 bias gets the lower value y gets relative to x.
		Bias(x, bias)
			var/k = Pow(1-bias, 3)
			var/denominator = (x * k - x + 1)
			if(denominator == 0) return 0
			return HandleOutput((x * k) / denominator)

		//Sigmoid function which compresses any real number x into the range of 0 to 1.
		Sigmoid(x)
			return Inverse(1 + Exp(-x))

		//This exponential falloff function returns 1 at x = 0.  The output decreases at rate of r as x decreases.  (r defaults to 0.01)
		Falloff(x, r = 0.01)
			return Exp(-r * x)

		//Raise E to the nth power
		Exp(n)
			return HandleOutput(E**n)

		//Raise x to the y power.  Default of y is 2
		Pow(x, y=2)
			return HandleOutput(x**y)

		Hypot(a, b)
			if(!b) return a * HYPOT
			return Sqrt(Pow(a) + Pow(b))

		Sin(x)
			return HandleOutput(sin(x))

		Arcsin(x)
			return HandleOutput(arcsin(x))

		Cos(x)
			return HandleOutput(cos(x))

		Arccos(x)
			return HandleOutput(arccos(x))

		Tan(x)
			return HandleOutput(tan(x))

		Arctan(x, y)
			return HandleOutput(y ? arctan(x,y) : arctan(x))

		//Make num equal to the closest value of either a or b if not between them (inclusive)
		Clamp(num, a, b)
			return HandleOutput(clamp(num, a, b))

		Min(a, b)
			return HandleOutput(min(a, b))

		Max(a, b)
			return HandleOutput(max(a, b))

		Abs(x)
			return HandleOutput(abs(x))

		//Checks if a number is even or odd.  Returns true if no remainder, thus even.  Returns false if there is a remainder, thus making it odd.
		IsEven(x)
			return x % 2 == 0

		Prob(x)
			return prob(x)

		Rand(a, b)
			if(a)
				if(b)
					return HandleOutput(rand(a, b))
				return HandleOutput(rand(Max(0, a), Min(0, a)))
			return HandleOutput(rand())

		Seed(x)
			rand_seed(x)

		//Round x down to the nearest multiple of 1
		Floor(x)
			return HandleOutput(round(x))

		//Round x down to the nearest multiple of N
		FloorN(x, N)
			return HandleOutput((round((x)/(N)) * (N)))

		//Round x up to the nearest multiple of 1
		Ceil(x)
			return HandleOutput((-round(-(x))))

		//Round x up to the nearest multiple of N
		CeilN(x, N)
			return HandleOutput((-round(-(x)/(N)) * (N)))

		Round(x, y)
			return HandleOutput(round(x, y))

		Sqrt(x)
			return HandleOutput(sqrt(x))

		//Natural log of x (base E)
		Log(x)
			return HandleOutput(log(x))

		//Logarithm of x (base 10)
		Log10(x)
			return HandleOutput(log(10, x))

		//Mean average of all numbers passed as arguments
		Mean()
			if(!args || !args?.len) return 0
			var/total = 0, n = args?.len
			for(var/x in args)
				if(!isnum(x)) continue
				total += x
			return HandleOutput(total / n)

		//Mode average of all numbers passed as arguments
		Mode()
			var/list/keys = list()
			for(var/x in args)
				if(keys[x]) keys[x]++
				else keys[x] = 1
			var/num
			for(var/x in keys)
				if(!num) num = x
				else if(keys[num] < keys[x]) num = x
			return HandleOutput(num)

		//Factorial of n.  r is cutoff.  Set to 0 for full factorial.
		Factorial(n, r=0)
			if(n in list(0, 1, 2)) return n
			switch(r)
				if(0) r = n
				if(1) return n
				if(2) return n * (n - 1)
			var/result = n
			for(var/c in 1 to (r-1))
				result *= (n - c)
			return HandleOutput(result)

		Delta(a1, a2)
			return HandleOutput(a2 - a1)

		Line(slope, x, y_intercept = 0)
			return HandleOutput(slope * x + y_intercept)

		Slope(x1, y1, x2, y2)
			var/deltaX = Delta(x1, x2)
			var/deltaY = Delta(y1, y2)
			return HandleOutput(deltaY / deltaX)

		//Provided a percentage, returns the represented value in range min-max.
		ValueFromPercentInRange(min, max, percent)
			return HandleOutput((percent * (max - min) / 100) + min)

		//Provided a value in range min-max, returns the representing percentage.
		PercentFromValueInRange(min, max, value)
			return HandleOutput(((value - min) * 100) / (max - min))

		Inverse(n)
			return HandleOutput(1 / n)

		InRange(val, min, max, inclusive = 1)
			if(inclusive)
				return min <= val && max >= val
			return min < val && max > val

		PlotLine(x1, y1, x2, y2)
			if(Abs(Delta(y1, y2)) < Abs(Delta(x1, x2)))
				if(x1 > x2)
					return PlotLineLow(x2, y2, x1, y1)
				else
					return PlotLineLow(x1, y1, x2, y2)
			else
				if(y1 > y2)
					return PlotLineHigh(x2, y2, x1, y1)
				else
					return PlotLineHigh(x1, y1, x2, y2)

		PlotLineLow(x1, y1, x2, y2)
			var/list/plots = list()
			var/dx = Delta(x1, x2), dy = Delta(y1, y2), yi = 1
			if(dy < 0)
				yi = -1
				dy = -dy
			var/diff = (2 * dy) - dx, y = y1

			for(var/x in x1 to x2)
				plots.Add(new/simple_vector(x, y))
				if(diff > 0)
					y += yi
					diff += (2 * (dy - dx))
				else
					diff += 2 * dy
			return plots

		PlotLineHigh(x1, y1, x2, y2)
			var/list/plots = list()
			var/dx = Delta(x1, x2), dy = Delta(y1, y2), xi = 1
			if(dx < 0)
				xi = -1
				dx = -dx
			var/diff = (2 * dx) - dy, x = x1
			for(var/y in y1 to y2)
				plots.Add(new/simple_vector(x, y))
				if(diff > 0)
					x += xi
					diff += (2 * (dx - dy))
				else
					diff += 2 * dx
			return plots

simple_vector
	var
		x
		y
		z

	New(_x = 1, _y = 1, _z = 1)
		x = _x
		y = _y
		z = _z