mob/proc/AppearanceOn()

//	AppearanceOff()

	if(!src.appearance_flags||src.appearance_flags<32)
		src.appearance_flags=32

	src.filters = filter(type="motion_blur", x=0,y=0)

	src.overlays-=src.AFKIcon

	src.color=MobColor

	if(src.TransActive()==1)
		if(src.Race=="Alien")
			if(src.Form1Overlay)
				var/image/im=image(icon=src.Form1Overlay, pixel_x=src.Form1OverlayX, pixel_y=src.Form1OverlayY)
				src.overlays+=im
	if(src.TransActive()==2)
		if(src.Race=="Alien")
			if(src.Form2Overlay)
				var/image/im=image(icon=src.Form2Overlay, pixel_x=src.Form2OverlayX, pixel_y=src.Form2OverlayY)
				src.overlays+=im
	if(src.TransActive()==3)
		if(src.Race=="Alien")
			if(src.Form3Overlay)
				var/image/im=image(icon=src.Form3Overlay, pixel_x=src.Form3OverlayX, pixel_y=src.Form3OverlayY)
				src.overlays+=im
	if(src.TransActive()==4)
		if(src.Race=="Alien")
			if(src.Form4Overlay)
				var/image/im=image(icon=src.Form4Overlay, pixel_x=src.Form4OverlayX, pixel_y=src.Form4OverlayY)
				src.overlays+=im
		if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
			src.overlays+=FurSSJ4
			src.overlays+=ClothingSSJ4
			src.overlays+=TailSSJ4

	if(src.ActiveBuff)
		if(src.ActiveBuff.IconLock)
			var/image/im=image(icon=src.ActiveBuff.IconLock, pixel_x=src.ActiveBuff.LockX, pixel_y=src.ActiveBuff.LockY, layer=FLOAT_LAYER-src.ActiveBuff.IconLayer)
			im.blend_mode=src.ActiveBuff.IconLockBlend
			im.transform*=src.ActiveBuff.OverlaySize
			if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
				im.transform*=3
			if(src.ActiveBuff.IconApart)
				im.appearance_flags+=70
			if(src.ActiveBuff.IconUnder)
				src.underlays+=im
			else
				src.overlays+=im
		if(src.ActiveBuff.StripEquip)
			if(src.ActiveBuff.AssociatedGear)
				src.overlays-=image(src.ActiveBuff.AssociatedGear.icon, pixel_x=src.ActiveBuff.AssociatedGear.pixel_x, pixel_y=src.ActiveBuff.AssociatedGear.pixel_y, layer=FLOAT_LAYER-3)
			if(src.ActiveBuff.AssociatedLegend)
				src.overlays-=image(src.ActiveBuff.AssociatedLegend.icon, pixel_x=src.ActiveBuff.AssociatedLegend.pixel_x, pixel_y=src.ActiveBuff.AssociatedLegend.pixel_y, layer=FLOAT_LAYER-3)

		if(src.ActiveBuff.ManaGlow)
			filters = null
			filters += filter(type="drop_shadow",x=0,y=0,size=src.ActiveBuff.ManaGlowSize, offset=src.ActiveBuff.ManaGlowSize/2, color=src.ActiveBuff.ManaGlow)
			GlowFilter = filters[filters.len]
			filters += filter(type="motion_blur", x=0,y=0)

	if(src.SpecialBuff)
		if(src.SpecialBuff.IconLock)
			var/image/im=image(icon=src.SpecialBuff.IconLock, pixel_x=src.SpecialBuff.LockX, pixel_y=src.SpecialBuff.LockY, layer=FLOAT_LAYER-src.SpecialBuff.IconLayer)
			im.blend_mode=src.SpecialBuff.IconLockBlend
			im.transform*=src.SpecialBuff.OverlaySize
			if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
				im.transform*=3
			if(src.SpecialBuff.IconApart)
				im.appearance_flags+=70
			if(src.SpecialBuff.IconUnder)
				src.underlays+=im
			else
				src.overlays+=im
		if(src.SpecialBuff.StripEquip)
			if(src.SpecialBuff.AssociatedGear)
				src.overlays-=image(src.SpecialBuff.AssociatedGear.icon, pixel_x=src.SpecialBuff.AssociatedGear.pixel_x, pixel_y=src.SpecialBuff.AssociatedGear.pixel_y, layer=FLOAT_LAYER-3)
			if(src.SpecialBuff.AssociatedLegend)
				src.overlays-=image(src.SpecialBuff.AssociatedLegend.icon, pixel_x=src.SpecialBuff.AssociatedLegend.pixel_x, pixel_y=src.SpecialBuff.AssociatedLegend.pixel_y, layer=FLOAT_LAYER-3)

		if(src.SpecialBuff.ManaGlow)
			filters = null
			filters += filter(type="drop_shadow",x=0,y=0,size=src.SpecialBuff.ManaGlowSize, offset=src.SpecialBuff.ManaGlowSize/2, color=src.SpecialBuff.ManaGlow)
			GlowFilter = filters[filters.len]
			filters += filter(type="motion_blur", x=0,y=0)

	if(src.StanceBuff)
		if(src.StanceBuff.IconLock)
			var/image/im=image(icon=src.StanceBuff.IconLock, pixel_x=src.StanceBuff.LockX, pixel_y=src.StanceBuff.LockY, layer=FLOAT_LAYER-src.StanceBuff.IconLayer)
			im.blend_mode=src.StanceBuff.IconLockBlend
			im.transform*=src.StanceBuff.OverlaySize
			if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
				im.transform*=3
			if(src.SpecialBuff.IconApart)
				im.appearance_flags+=70
			if(src.StanceBuff.IconUnder)
				src.underlays+=im
			else
				src.overlays+=im
	if(src.StyleBuff)
		if(src.StyleBuff.IconLock)
			var/image/im=image(icon=src.StyleBuff.IconLock, pixel_x=src.StyleBuff.LockX, pixel_y=src.StyleBuff.LockY, layer=FLOAT_LAYER-src.StyleBuff.IconLayer)
			im.blend_mode=src.StyleBuff.IconLockBlend
			im.transform*=src.StyleBuff.OverlaySize
			if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
				im.transform*=3
			if(src.StyleBuff.IconApart)
				im.appearance_flags+=70
			if(src.StyleBuff.IconUnder)
				src.underlays+=im
			else
				src.overlays+=im
	if(src.SlotlessBuffs.len>0)
		for(var/sb in SlotlessBuffs)
			var/obj/Skills/Buffs/SlotlessBuffs/b = SlotlessBuffs[sb]
			if(b)
				if(b.IconLock)
					var/image/im=image(icon=b.IconLock, pixel_x=b.LockX, pixel_y=b.LockY, layer=FLOAT_LAYER-b.IconLayer)
					im.blend_mode=b.IconLockBlend
					im.transform*=b.OverlaySize
					if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
						im.transform*=3
					if(b.IconApart)
						im.appearance_flags+=70
					if(b.IconUnder)
						src.underlays+=im
					else
						src.overlays+=im

				if(b.ManaGlow)
					filters = null
					filters += filter(type="drop_shadow",x=0,y=0,size=b.ManaGlowSize, offset=b.ManaGlowSize/2, color=b.ManaGlow)
					GlowFilter = filters[filters.len]
					filters += filter(type="motion_blur", x=0,y=0)

	for(var/obj/Items/I in src)
		if(I.suffix=="*Equipped*"||I.suffix=="*Equipped (Second)*"||I.suffix=="*Equipped (Third)*")
			if(istype(I, /obj/Items/Gear/Mobile_Suit)&&passive_handler.Get("Piloting"))
				continue
			if(!istype(I, /obj/Items/Sword)&&!istype(I, /obj/Items/Gear)&&!istype(I, /obj/Items/Enchantment/Staff)&&(src.Transformed||src.Oozaru))
				continue
			I.suffix=null
			equippedArmor = null
			equippedSword = null
			I.AlignEquip(src)


	src.Hairz("Add")

	var/NH
	for(var/obj/Skills/Buffs/B in src)
		if(B.NoTopOverlay)
			NH=1
	if(src.ActiveBuff)
		if(src.ActiveBuff.TopOverlayLock&&!NH)
			var/image/im=image(icon=src.ActiveBuff.TopOverlayLock, pixel_x=src.ActiveBuff.TopOverlayX, pixel_y=src.ActiveBuff.TopOverlayY, layer=FLOAT_LAYER-1)
			im.blend_mode=src.ActiveBuff.IconLockBlend
			im.transform*=src.ActiveBuff.OverlaySize
			if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
				im.transform*=3
			if(src.ActiveBuff.IconApart)
				im.appearance_flags+=70
			src.overlays+=im
	if(src.SpecialBuff)
		if(src.SpecialBuff.TopOverlayLock&&!NH)
			var/image/im=image(icon=src.SpecialBuff.TopOverlayLock, pixel_x=src.SpecialBuff.TopOverlayX, pixel_y=src.SpecialBuff.TopOverlayY, layer=FLOAT_LAYER-1)
			im.blend_mode=src.SpecialBuff.IconLockBlend
			im.transform*=src.SpecialBuff.OverlaySize
			if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
				im.transform*=3
			if(src.SpecialBuff.IconApart)
				im.appearance_flags+=70
			src.overlays+=im
	if(src.StanceBuff)
		if(src.StanceBuff.TopOverlayLock&&!NH)
			var/image/im=image(icon=src.StanceBuff.TopOverlayLock, pixel_x=src.StanceBuff.TopOverlayX, pixel_y=src.StanceBuff.TopOverlayY, layer=FLOAT_LAYER-1)
			im.blend_mode=src.StanceBuff.IconLockBlend
			im.transform*=src.StanceBuff.OverlaySize
			if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
				im.transform*=3
			if(src.StanceBuff.IconApart)
				im.appearance_flags+=70
			src.overlays+=im
	if(src.StyleBuff)
		if(src.StyleBuff.TopOverlayLock&&!NH)
			var/image/im=image(icon=src.StyleBuff.TopOverlayLock, pixel_x=src.StyleBuff.TopOverlayX, pixel_y=src.StyleBuff.TopOverlayY, layer=FLOAT_LAYER-1)
			im.blend_mode=src.StyleBuff.IconLockBlend
			im.transform*=src.StyleBuff.OverlaySize
			if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
				im.transform*=3
			if(src.StyleBuff.IconApart)
				im.appearance_flags+=70
			src.overlays+=im
	if(src.SlotlessBuffs.len>0)
		for(var/sb in SlotlessBuffs)
			var/obj/Skills/Buffs/SlotlessBuffs/b = SlotlessBuffs[sb]
			if(b)
				if(b.TopOverlayLock)
					var/image/im=image(icon=b.TopOverlayLock, pixel_x=b.TopOverlayX, pixel_y=b.TopOverlayY, layer=FLOAT_LAYER-1)
					im.blend_mode=b.IconLockBlend
					im.transform*=b.OverlaySize
					if(src.CheckActive("Mobile Suit")&&src.ActiveBuff.BuffName!="Mobile Suit")
						im.transform*=3
					if(b.IconApart)
						im.appearance_flags+=70
					src.overlays+=im

	if(src.trans["tension"])
		var/image/tension=image('HTAura.dmi',pixel_x=-16, pixel_y=-4)
		var/image/tension2=image('HighTension.dmi',pixel_x=-32,pixel_y=-32)
		var/image/tensionh=image(src.Hair_HT, layer=FLOAT_LAYER-1)
		var/image/tensionhs=image(src.Hair_SHT, layer=FLOAT_LAYER-1)
		var/image/tensione=image('EyesHT.dmi', layer=FLOAT_LAYER-2)
		tension2.blend_mode=BLEND_ADD
		tensionh.blend_mode=BLEND_ADD
		tensionh.alpha=200
		tensionhs.blend_mode=BLEND_ADD
		tensionhs.alpha=130
		if(src.trans["tension"]==5)
			src.Hairz("Add")
			src.underlays+=tension
		if(src.trans["tension"]==20)
			src.underlays+=tension
			src.Hairz("Add")
			src.overlays+=tension2
		if(src.trans["tension"]==50)
			src.underlays+=tension
			src.overlays+=tensione
			src.Hairz("Add")
			src.overlays+=tensionh
			src.overlays+=tension2
		if(src.trans["tension"]==100)
			src.underlays+=tension
			src.overlays+=tensione
			src.Hairz("Add")
			src.overlays+=tensionhs
			src.overlays+=tension2

	if(src.Dead)
		src.overlays+='Halo.dmi'

	for(var/obj/Items/Gear/Mobile_Suit/I in src)
		if(I.suffix=="*Equipped*"||I.suffix=="*Equipped (Second)*"||I.suffix=="*Equipped (Third)*")
			if(passive_handler.Get("Piloting"))
				I.suffix=null
				I.AlignEquip(src)

mob/proc/AppearanceOff()
	src.overlays=null
	src.underlays=null