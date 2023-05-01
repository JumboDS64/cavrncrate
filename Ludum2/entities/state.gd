class_name State
extends Node

var entity:Entity
var machine:Machine
var sensors:Array = []
var sensorsUpdated = false # Sensors don't work if you check immedeately; a one-frame prep is needed before the sensors can detect anything, so we use this variable to wait over that one frame
#var joints:Array = [] # For limiting the movement of other entities
var active = false

func init(_machine):
	machine = _machine
	entity = machine.entity
	for i in self.get_children():
		if(i is Sensor):
			sensors.append(i)
			i.init(self)
			remove_child(i)
func name():
	pass
func enter(_msg := {}):
	for i in sensors: i.open()
	sensorsUpdated = false
func act(_delta: float):
	sensorsUpdated = true
func exit():
	for i in sensors: i.close()
func goto(_stateName,_msg:Dictionary={}):
	machine.goto(_stateName,_msg)

func checkSensors():
	for s in sensors:
		s.sense()
