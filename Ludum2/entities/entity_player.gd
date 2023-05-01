@tool
class_name Entity_Player
extends Entity

func initMachines():
	super.initMachines()
	add_machine_back("main")
	machines["main"].init_start(self)
	machines["main"].add_state("state_player_idle")
	machines["main"].add_state("state_player_run")
	machines["main"].add_state("state_player_jump")
	machines["main"].add_state("state_player_fall")
	machines["main"].add_state("state_player_kick")
	machines["main"].add_state("state_player_win")
	machines["main"].init_end("player_idle")
func move(delta):
	move_and_slide(delta)
