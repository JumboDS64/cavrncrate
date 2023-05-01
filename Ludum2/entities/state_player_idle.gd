class_name State_Player_Idle
extends State

func name():
	return "player_idle"

func enter(_msg := {}):
	super.enter(_msg)
	entity.goAnimate("entity_player/idle")
func exit():
	super.exit()

func act(delta):
	var v = Globals.getJoyVec()
	entity.body.velocity.x = 0
	entity.body.velocity.y = 0
	if(v.length() > 0):
		goto("player_run")
	if(entity.floorNormal == null):
		goto("player_fall")
	if(Input.is_action_just_pressed("jump")):
		goto("player_jump")
	if(Input.is_action_just_pressed("attack")):
		goto("player_kick")
	super.act(delta)
