@tool
extends Node

#var BD_TEST_SOLID = BlockDef_Test_Solid.new()
var idealFPS = 60
var NORMAL_DIAG = sqrt(2)/2 #side length of a normal vector that's 45 degrees away from an axis
var VEC_NAN = Vector3(NAN,NAN,NAN)
var PI2 = PI/2
var TWO_PI = PI*2
var GRAVITY = 8
var STAT_RUNPOW = 10
var STAT_RUNMAX = 100
var STAT_RUNFRIC = 10

func getJoyVec():
	var out = Vector2()
	if(Input.is_action_pressed("move_left")):
		out.x -= 1
	if(Input.is_action_pressed("move_right")):
		out.x += 1
	return out

func angleDiff(a,b):
	return ((b-a)%(TWO_PI))-PI

func scalarProject(a:Vector3,b:Vector3):
	return a.dot(b.normalized())

func vectorStability(v:Vector3):
	if(v.y == 1): return 3
	elif(v.y >= Globals.NORMAL_DIAG): return 2
	else: return 1
