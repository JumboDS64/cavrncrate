@tool
class_name Entity_Goal
extends Entity

@export var skin:int

func toolVis():
	super.toolVis()
	sprite.get_node("Sprite2D").frame_coords.y = skin
func init_simple():
	super.init_simple()
	sprite.get_node("Sprite2D").frame_coords.y = skin
func initMachines():
	super.initMachines()
	add_machine_back("main")
	machines["main"].init_start(self)
	machines["main"].add_state("state_goal")
	machines["main"].init_end("goal")
	#print(machines["main"].states)
func move(delta):
	pass
