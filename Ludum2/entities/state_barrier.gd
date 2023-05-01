class_name State_Barrier
extends State

func name():
	return "barrier"

func enter(_msg := {}):
	super.enter(_msg)
	entity.sprite.get_node("base").frame_coords.x = 0
func exit():
	super.exit()

func act(delta):
	if(entity.map.getFlag(entity.flagChannel) != entity.negated):
		entity.sprite.get_node("base").frame_coords.x = 1
		sensors[0].sense()
		if(!sensors[0].has_results()): #CHECK: this will cause it to stop at slightly varying positions outside objects depending on the framerate, i think
			entity.body.get_child(0).shape.size.x += 480*delta
			sensors[0].shape.position.x += 480*delta
			entity.body.get_child(0).position.x += 240*delta
			entity.goAnimate("entity_barrier/sfx_extend")
		else:
			entity.goAnimate("entity_barrier/sfx_none")
	else:
		entity.sprite.get_node("base").frame_coords.x = 0
		entity.body.get_child(0).shape.size.x -= 480*delta
		if(entity.body.get_child(0).shape.size.x < 16):
			entity.body.get_child(0).shape.size.x = 16
		sensors[0].shape.position.x -= 480*delta
		if(sensors[0].shape.position.x < 16):
			sensors[0].shape.position.x = 16
		entity.body.get_child(0).position.x -= 240*delta
		if(entity.body.get_child(0).position.x < 8):
			entity.body.get_child(0).position.x = 8
			entity.goAnimate("entity_barrier/sfx_none")
		else:
			entity.goAnimate("entity_barrier/sfx_retract")
	super.act(delta)
