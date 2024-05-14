mob/var/usingUBW = FALSE

mob
	proc
		UnlimitedBladeWorks()
			if(usingUBW) return
			var/list/targets = list()
			for(var/mob/m in range(15))
				targets |= m
			var/swapmap/newMap = SwapMaps_CreateFromTemplate("UBW")
			var/turf/center = newMap.CenterTile()
			usingUBW = TRUE
			for(var/mob/teleportThese in targets)
				teleportThese.PrevX=teleportThese.x
				teleportThese.PrevY=teleportThese.y
				teleportThese.PrevZ=teleportThese.z
				teleportThese.in_tmp_map = newMap.id
				teleportThese.loc = locate(center.x+rand(-10,10), center.y+rand(-10,10), center.z)

		stopUnlimitedBladeWorks()
			var/swapmap/map = swapmaps_byname[in_tmp_map]
			usingUBW = FALSE
			for(var/mob/m in block(map.x1, map.y1, map.z1, map.x2, map.y2))
				m.x = m.PrevX
				m.y = m.PrevY
				m.z = m.PrevZ
				m.PrevX = null
				m.PrevY = null
				m.PrevZ = null
				m.in_tmp_map = null
			map.Del()