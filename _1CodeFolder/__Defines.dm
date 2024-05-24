client/preload_rsc = 2

proc/log_func(x, a, b)
	return a * (log(x) / log(10) - b )

#define isai(a) istype(a, /mob/Player/AI)
#define isNPC(a) istype(a, /mob/)
#define TICK_USAGE world.tick_usage

#define TICK_CHECK_LIMIT 75

/// Returns true if tick_usage is above the limit
#define TICK_CHECK ( TICK_USAGE > TICK_CHECK_LIMIT)
/// runs stoplag if tick_usage is above the limit
#define CHECK_TICK ( TICK_CHECK ? stoplag() : 0 )

/// Returns true if tick usage is above 95, for high priority usage
#define TICK_CHECK_HIGH_PRIORITY ( TICK_USAGE > 95 )
/// runs stoplag if tick_usage is above 95, for high priority usage
#define CHECK_TICK_HIGH_PRIORITY ( TICK_CHECK_HIGH_PRIORITY? stoplag() : 0 )

//Key thing that stops lag. Cornerstone of performance in ss13, Just sitting here, in unsorted.dm. Now with dedicated file!

#define BUILD_PAINT "PAINT"
#define BUILD_RECT "RECTANGLE"
#define BUILD_RECT_HOLLOW "HOLLOW RECTANGLE"
#define BUILD_LINE "LINE"
#define BUILD_FILL "FILL"
#define BUILD_ELLIPSE "ELLIPSE"
#define BUILD_SELECT "SELECT"
#define BUILD_PICK "PICK"

#define BUILD_TURFS "Turfs"
#define BUILD_OBJS "Map Objects"

#define BUILD_MAX_DIM 50

#define TILE_HEIGHT 32
#define TILE_WIDTH 32

#define subtypesof(M) (typesof(M) - (M))

#define HUMAN /race/human
#define NAMEKIAN /race/namekian
#define SAIYAN /race/saiyan
#define DEMON /race/demon
#define MAJIN /race/majin
#define MAKYO /race/makyo
#define DRAGON /race/dragon
#define ELF /race/high_faoroan
#define YOKAI /race/yokai
#define ELDRITCH /race/eldritch
#define BEASTMAN /race/beastman
#define GAJALAKA /race/gajalaka
#define CHANGELING /race/changeling

#define DEBUG_DAMAGE 0
#define DEBUG_ITEM_DAMAGE 0
#define DEBUG_MELEE 0
#define DEBUG_AUTOHIT 0
#define DEBUG_GRAPPLE 0
#define DEBUG_PROJECTILE 0

var/list/font_rsc=list('fonts/Gotham Book.otf') // forces it into the rsc.

proc
	stoplag()
		var/tickstosleep = 1
		do
			sleep(world.tick_lag*tickstosleep)
			tickstosleep *= 2 //increase the amount we sleep each time since sleeps are expensive (5-15 proc calls)
		while(world.tick_usage > 75 && (tickstosleep*world.tick_lag) < 32) //stop if we get to the point where we sleep for seconds at a time
