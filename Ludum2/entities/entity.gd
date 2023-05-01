@tool
class_name Entity
extends Node

var mode
var map:Map
var body:CharacterBody2D
var sprite:Node2D
var audioplayer:AudioStreamPlayer2D
var audioplayer_shadow:AudioStreamPlayer2D
var animPlayer:AnimationPlayer
var floorNormal
var machines
var machines_order
@export var init_pos:Vector2
@export var facing:Vector2

func _ready():
	if Engine.is_editor_hint():
		init_simple()
func _process(delta):
	if Engine.is_editor_hint():
		toolVis()

func init_simple():
	body = get_node("body")
	sprite = get_node("sprite")
	body.position = init_pos*16
	sprite.transform = body.transform
func toolVis():
	get_node("body").position = init_pos*16
	get_node("sprite").transform = get_node("body").transform

func init(_map:Map):
	init_simple()
	#body.motion_mode = body.MotionMode.MOTION_MODE_FLOATING
	audioplayer = get_node("audioplayer")
	audioplayer_shadow = get_node("audioplayer_shadow")
	map = _map
	mode = map.mode
	animPlayer = get_node("sprite/AnimationPlayer")
	floorNormal = Vector2()
	initMachines()

func initMachines():
	machines = {}
	machines_order = []
func add_machine_back(name):
	machines[name] = Machine.new()
	machines_order.push_back(name)
func add_machine_front(name):
	machines[name] = Machine.new()
	machines_order.push_front(name) #costly!... luckily this is a small array
func goto(machine, _state:String, _msg:Dictionary={}):
	machines[machine].goto(_state,_msg)

func act(delta):
	for m in machines_order:
		machines[m].act(delta)
	move(delta)
	var _kc = KinematicCollision2D.new()
	var _tm = body.test_move(body.transform,Vector2.DOWN*1,_kc)
	if(_tm):
		floorNormal = _kc.get_normal()
	else:
		floorNormal = null
	updateVis()
	if(audioplayer != null):
		audioplayer.position = body.position
		audioplayer_shadow.position = map.mode.camera.position*2 - body.position
func move(delta):
	pass
func move_and_collide(delta):
	body.move_and_collide(body.velocity*delta)
func move_and_slide(delta):
	body.move_and_slide()
	body.velocity = body.get_real_velocity()
func updateVis():
	sprite.transform = body.transform

func faceDir(_joy):
	if(_joy.length_squared() > 0): facing = _joy.normalized()
	if(_joy.x < 0):
		body.scale.y = -1
		body.rotation = PI
	elif(_joy.x > 0):
		body.scale.y = 1
		body.rotation = 0

func goAnimate(anim):
	if(animPlayer && animPlayer.has_animation(anim)):
		animPlayer.play(anim)
		animPlayer.speed_scale = 1
func set_animSpeed(s):
	if(animPlayer):
		animPlayer.speed_scale = s
