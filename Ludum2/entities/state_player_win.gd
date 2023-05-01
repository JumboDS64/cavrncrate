class_name State_Player_Win
extends State

var timer

func name():
	return "player_win"

func enter(_msg := {}):
	super.enter(_msg)
	timer = 100
	entity.goAnimate("entity_player/win")
func exit():
	super.exit()

func act(delta):
	if(abs(entity.body.velocity.x) > Globals.STAT_RUNFRIC):
		entity.body.velocity.x -= sign(entity.body.velocity.x)*Globals.STAT_RUNFRIC
	else:
		entity.body.velocity.x = 0
	if(entity.floorNormal == null):
		entity.body.velocity.y += Globals.GRAVITY
	else:
		entity.body.velocity.y = 0
	timer -= 1
	if(timer <= 0):
		entity.map.mode.advanceLevel()
	super.act(delta)
