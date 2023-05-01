extends Node

enum GameMode {TITLE,LEVSELECT,LEVEL}
var mode = GameMode.LEVEL
var modeScene
var audioStreamPlayer
var musicStack = []

func _ready():
	#var scaleFactor = 2
	#if DisplayServer.screen_get_dpi() >= 144: # approximate point by which a display is probably using double pixel resolution; the actual resolution-getting method is currently only implemented for MacOS
	#	scaleFactor = 2
	#print(DisplayServer.screen_get_dpi())
	#get_window().set_size(Vector2(512*scaleFactor, 384*scaleFactor))
	audioStreamPlayer = get_node("audioStreamPlayer")
	modeScene = get_node("mode_none")
	setMode("mode_title")

func setMode(path):
	remove_child(modeScene)
	modeScene = load("res://"+path+".tscn").instantiate()
	add_child(modeScene)
	modeScene.init(self)

# ENGINETODO: support for transitioning smoothly between two tracks without inserting silence
func changeMusic(music:AudioStream):
	audioStreamPlayer.stop()
	audioStreamPlayer.set_stream(music)
	audioStreamPlayer.play()
func changeMusic_silence():
	audioStreamPlayer.stop()
func pushMusic(music:AudioStream):
	musicStack.push_back({"music":audioStreamPlayer.get_stream(), "pos":audioStreamPlayer.get_playback_position()})
	audioStreamPlayer.stop()
	audioStreamPlayer.set_stream(music)
	audioStreamPlayer.play()
func popMusic():
	audioStreamPlayer.stop()
	if(musicStack.length() <= 0): return
	var info = musicStack.pop_back()
	audioStreamPlayer.set_stream(info["music"])
	audioStreamPlayer.play(info["pos"])
