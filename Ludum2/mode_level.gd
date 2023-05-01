extends Mode

var map
var camera
var playerEntity = null
var ui
var map_order = ["map_1", "map_3", "map_2", "map_4", "map_5", "map_6", "map_7"]
var map_cur = 2

func init(_main):
	super.init(_main)
	main.changeMusic(preload("res://assets/music/Ingame.ogg"))
	map = get_node("map_none")
	camera = get_node("camera")
	ui = get_node("ui")
	loadMap(map_order[map_cur])

func _physics_process(delta):
	act(delta)
	if(Input.is_action_just_pressed("restart_level")):
		loadMap(map_order[map_cur])

func act(delta):
	map.act(delta)
	camera.position.x = 256
	camera.position.y = 192
	#if(camFocus != null):
	#	camera.position.x = camFocus.body.position.x
	#	camera.position.y = camFocus.body.position.y - 20
	updateUI()

func loadMap(path):
	remove_child(map)
	map = load("res://maps/"+path+".tscn").instantiate()
	add_child(map)
	map.init(self)
	playerEntity = map.get_node("entity_player")

func updateUI():
	pass

func winLevel():
	if(playerEntity.machines["main"].curState_name != "player_win"):
		playerEntity.goto("main","player_win")
func advanceLevel():
	map_cur += 1
	if(map_cur < len(map_order)):
		loadMap(map_order[map_cur])
	else:
		main.setMode("mode_level")
		#print("game win!")
