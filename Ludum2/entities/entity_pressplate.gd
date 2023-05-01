@tool
class_name Entity_Pressplate
extends Entity

@export var flagChannel:int = 0

func toolVis():
	super.toolVis()
	sprite.get_node("Sprite2D").frame_coords.y = flagChannel
func init_simple():
	super.init_simple()
	sprite.get_node("Sprite2D").frame_coords.y = flagChannel
func initMachines():
	super.initMachines()
	add_machine_back("main")
	machines["main"].init_start(self)
	machines["main"].add_state("state_pressplate")
	machines["main"].init_end("pressplate")
func move(delta):
	pass
