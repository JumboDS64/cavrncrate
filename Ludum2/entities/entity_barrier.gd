@tool
class_name Entity_Barrier
extends Entity

#NOTE: I had to set the body's collisionshape as "local to scene" for the state's hitbox-rescaling to work correctly.

@export var flagChannel:int = 0
@export var init_rot:float = 0
@export var negated:bool = false

func toolVis():
	get_node("body").position = init_pos*16
	get_node("body").rotation = init_rot*Globals.PI2
	get_node("sprite").transform = get_node("body").transform
	get_node("sprite").get_node("shaft").region_rect.position.y = flagChannel*16
	get_node("sprite").get_node("cap").frame_coords.y = flagChannel
	get_node("sprite").get_node("base").frame_coords.y = flagChannel
func init_simple():
	super.init_simple()
	sprite.get_node("shaft").region_rect.position.y = flagChannel*16
	sprite.get_node("cap").frame_coords.y = flagChannel
	sprite.get_node("base").frame_coords.y = flagChannel
	body.rotation = init_rot*Globals.PI2
	sprite.transform = body.transform
func initMachines():
	super.initMachines()
	add_machine_back("main")
	machines["main"].init_start(self)
	machines["main"].add_state("state_barrier")
	machines["main"].init_end("barrier")
func move(delta):
	pass
func updateVis():
	sprite.get_node("cap").position.x = body.get_child(0).shape.size.x - 8
	sprite.get_node("shaft").region_rect.size.x = body.get_child(0).shape.size.x - 16
	sprite.get_node("shaft").position.x = body.get_child(0).shape.size.x/2
	sprite.transform = body.transform
