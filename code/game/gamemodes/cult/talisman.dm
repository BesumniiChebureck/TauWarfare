/obj/item/weapon/paper/talisman
	icon_state = "paper_talisman"
	var/datum/religion_rites/rite
	var/datum/religion/religion

	var/disposable = FALSE

/obj/item/weapon/paper/talisman/atom_init(mapload, datum/religion/_religion, datum/religion_rites/_rite)
	. = ..()
	rite = _rite
	religion = _religion

/obj/item/weapon/paper/talisman/Destroy()
	rite = null
	religion = null
	return ..()

/obj/item/weapon/paper/talisman/attack_self(mob/living/user)
	if(!religion?.is_member(user))
		user.examinate(src)
		return

	user.take_overall_damage(rand(5, 8), rand(1, 5))
	rite?.perform_rite(user, src)

	if(disposable)
		qdel(src)

/obj/item/weapon/paper/talisman/chaplain/examine(mob/user)
	..()
	if(religion?.is_member(user) && rite)
		var/rite_info = religion.rites_info[rite.name] ? religion.rites_info[rite.name] : religion.get_rite_info(rite)
		to_chat(user, "<span class='[religion.style_text]'>Божественным почерком написано: [rite_info]</span>.")

/obj/item/weapon/paper/talisman/cult
	icon_state = "scrap_bloodied"

/obj/item/weapon/paper/talisman/cult/examine(mob/user)
	..()
	if(religion?.is_member(user) && rite)
		var/rite_info = religion.rites_info[rite.name] ? religion.rites_info[rite.name] : religion.get_rite_info(rite)
		to_chat(user, "<span class='[religion.style_text]'>Кровью наскрябано: [rite_info]</span>.")
