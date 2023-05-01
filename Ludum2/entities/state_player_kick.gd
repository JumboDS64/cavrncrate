class_name State_Player_Kick
extends State

var timer

func name():
	return "player_kick"

func enter(_msg := {}):
	super.enter(_msg)
	timer = 15
	entity.goAnimate("entity_player/kick")
func exit():
	super.exit()

func act(delta):
	if(sensorsUpdated):
		sensors[0].sense()
		if(sensors[0].has_results()):
			for e in sensors[0].results:
				if(e is Entity_Crate):
					e.goAnimate("entity_crate/sfx_kicked")
					e.goto("main","crate_slide",{"dir":entity.facing})
	entity.body.velocity.y += Globals.GRAVITY
	timer -= 1
	if(timer == 0):
		if(entity.floorNormal == null):
			goto("player_fall")
		else:
			if(Globals.getJoyVec().length_squared() > 0):
				goto("player_run")
			else:
				goto("player_idle")
	super.act(delta)
