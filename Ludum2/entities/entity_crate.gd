@tool
class_name Entity_Crate
extends Entity

func initMachines():
	super.initMachines()
	add_machine_back("main")
	machines["main"].init_start(self)
	machines["main"].add_state("state_crate_idle")
	machines["main"].add_state("state_crate_slide")
	machines["main"].init_end("crate_idle")
	#print(machines["main"].states)
func move(delta):
	move_and_collide(delta)
