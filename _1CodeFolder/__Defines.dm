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



proc
	stoplag()
		var/tickstosleep = 1
		do
			sleep(world.tick_lag*tickstosleep)
			tickstosleep *= 2 //increase the amount we sleep each time since sleeps are expensive (5-15 proc calls)
		while(world.tick_usage > 75 && (tickstosleep*world.tick_lag) < 32) //stop if we get to the point where we sleep for seconds at a time
