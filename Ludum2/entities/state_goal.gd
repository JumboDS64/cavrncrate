class_name State_Goal
extends State

var wonstate = false

func name():
	return "goal"

func enter(_msg := {}):
	super.enter(_msg)
func exit():
	super.exit()

func act(delta):
	if(sensorsUpdated):
		sensors[0].sense()
		if(sensors[0].has_results()):
			for e in sensors[0].results:
				if(!wonstate && e is Entity_Crate_Goal && e.machines["main"].curState_name == "crate_idle"):
					entity.sprite.get_node("Sprite2D").frame_coords.x = 1
					entity.map.mode.winLevel()
					wonstate = true
	super.act(delta)
