extends Mode

func init(_main):
	super.init(_main)

func _process(delta):
	if(Input.is_anything_pressed()):
		main.setMode("mode_level")
