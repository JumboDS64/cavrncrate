class_name State_Pressplate
extends State

var pressed = 0

func name():
	return "pressplate"

func enter(_msg := {}):
	super.enter(_msg)
	entity.sprite.get_node("Sprite2D").frame_coords.x = 0
func exit():
	super.exit()

func act(delta):
	var _shouldPressed = false
	if(sensorsUpdated):
		sensors[0].sense()
		if(sensors[0].has_results()):
			for e in sensors[0].results:
				if(e is Entity):
					_shouldPressed = true
	if(_shouldPressed):
		pressed += 1
	else:
		pressed = 0
	if(pressed == 1):
		entity.map.setFlag(entity.flagChannel, !entity.map.getFlag(entity.flagChannel))
	if(_shouldPressed):
		if(entity.map.getFlag(entity.flagChannel)):
			entity.sprite.get_node("Sprite2D").frame_coords.x = 3
		else:
			entity.sprite.get_node("Sprite2D").frame_coords.x = 1
	else:
		if(entity.map.getFlag(entity.flagChannel)):
			entity.sprite.get_node("Sprite2D").frame_coords.x = 2
		else:
			entity.sprite.get_node("Sprite2D").frame_coords.x = 0
	super.act(delta)
