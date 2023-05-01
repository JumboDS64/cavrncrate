class_name Map
extends Node

var mode
var camera
var flags = [false,false,false]

func act(delta):
	for i in get_children():
		if(i is Entity):
			i.act(delta)

func init(_mode):
	mode = _mode
	camera = _mode.camera
	for i in get_children():
		if(i is Entity):
			i.init(self)

func getFlag(id:int):
	return flags[id]
func setFlag(id:int, b:bool):
	flags[id] = b
func toggleFlag(id:int):
	if(flags[id]): flags[id] = false
	else: flags[id] = true
