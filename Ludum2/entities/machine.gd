class_name Machine
extends Node

var entity
var states:Dictionary
var curState_name:String
var nexState_name
var nexState_msg
var firstState:String

func init_start(_entity):
	entity = _entity
	states = {}
func add_state(_scenePath):
	var neu = load("res://entities/"+_scenePath+".tscn").instantiate()
	states[neu.name()] = neu
	neu.init(self)
func init_end(_firstState):
	firstState = _firstState
	curState_name = get_firstState()
	get_curState().enter()

func goto(_name:String,_msg:Dictionary={}):
	nexState_name = _name
	nexState_msg = _msg
func act(delta):
	#print(get_curState().name())
	get_curState().act(delta)
	if(nexState_name != null):
		get_curState().exit()
		curState_name = nexState_name
		get_curState().enter(nexState_msg)
	nexState_name = null
	nexState_msg = null

func get_curState():
	return states[curState_name]
func get_firstState():
	return firstState
