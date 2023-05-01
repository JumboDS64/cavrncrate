class_name PosAudio
extends Node2D

var entity:Entity
var camera
var audioplayer_main:AudioStreamPlayer2D
var audioplayer_shadow:AudioStreamPlayer2D

func init(_entity, _camera):
	entity = _entity
	camera = _camera
