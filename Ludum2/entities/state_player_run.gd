class_name State_Player_Run
extends State

func name():
	return "player_run"

func enter(_msg := {}):
	super.enter(_msg)
	entity.goAnimate("entity_player/run")
func exit():
	super.exit()

func act(delta):
	var v = Globals.getJoyVec()
	entity.faceDir(v)
	#entity.body.velocity.y = 0
	if(v.length_squared() > 0):
		if(abs(entity.body.velocity.x) < Globals.STAT_RUNMAX-Globals.STAT_RUNPOW):
			entity.body.velocity.x += v.x*Globals.STAT_RUNPOW
		else:
			entity.body.velocity.x = sign(v.x)*Globals.STAT_RUNMAX
	else:
		if(abs(entity.body.velocity.x) > Globals.STAT_RUNFRIC):
			entity.body.velocity.x -= sign(entity.body.velocity.x)*Globals.STAT_RUNFRIC
		else:
			entity.body.velocity.x = 0
			goto("player_idle")
	if(entity.floorNormal == null):
		goto("player_fall")
	if(Input.is_action_just_pressed("jump")):
		goto("player_jump")
	if(Input.is_action_just_pressed("attack")):
		goto("player_kick")
	super.act(delta)
