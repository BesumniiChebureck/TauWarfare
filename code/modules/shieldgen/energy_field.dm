
//---------- actual energy field

/obj/effect/energy_field
	name = "energy field"
	desc = "Impenetrable field of energy, capable of blocking anything as long as it's active."
	icon = 'icons/obj/machines/shielding.dmi'
	icon_state = "shieldsparkles"
	anchored = TRUE
	layer = 4.1		//just above mobs
	density = FALSE
	invisibility = 101
	var/strength = 0
	var/ticks_recovering = 10

/obj/effect/energy_field/ex_act(severity)
	Stress(0.5 + severity)

/obj/effect/energy_field/bullet_act(obj/item/projectile/Proj, def_zone)
	. = ..()
	Stress(Proj.damage / 10)

/obj/effect/energy_field/proc/Stress(severity)
	strength -= severity

	//if we take too much damage, drop out - the generator will bring us back up if we have enough power
	ticks_recovering = min(ticks_recovering + 2, 10)
	if(strength < 1)
		invisibility = 101
		density = FALSE
		ticks_recovering = 10
		strength = 0
	else if(strength >= 1)
		invisibility = 0
		density = TRUE

/obj/effect/energy_field/proc/Strengthen(severity)
	strength += severity

	//if we take too much damage, drop out - the generator will bring us back up if we have enough power
	if(strength >= 1)
		invisibility = 0
		density = TRUE
	else if(strength < 1)
		invisibility = 101
		density = FALSE

/obj/effect/energy_field/CanPass(atom/movable/mover, turf/target, height=1.5, air_group = 0)
	//Purpose: Determines if the object (or airflow) can pass this atom.
	//Called by: Movement, airflow.
	//Inputs: The moving atom (optional), target turf, "height" and air group
	//Outputs: Boolean if can pass.

	//return (!density || !height || air_group)
	return !density
