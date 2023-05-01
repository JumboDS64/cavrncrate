class_name State_Crate_Slide
extends State

var slideDir
var t

func name():
	return "crate_slide"

func enter(_msg := {}):
	super.enter(_msg)
	slideDir = _msg["dir"]
	entity.body.velocity = _msg["dir"]*200
func exit():
	super.exit()

func act(delta):
	var space_state = entity.body.get_world_2d().direct_space_state
	var pos = entity.body.position + Vector2.UP*0.7
	var ray = slideDir*17
	var query = PhysicsRayQueryParameters2D.create(pos, pos+ray)
	var result = space_state.intersect_ray(query)
	if(result.has("normal")):
		if(result["normal"].y <= -Globals.NORMAL_DIAG):
			entity.body.velocity = slideDir.rotated(result["normal"].angle()+Globals.PI2)*200
		else:
			entity.goAnimate("entity_crate/sfx_hitwall")
			goto("crate_idle")
	else:
		pos = entity.body.position - Vector2.DOWN*28 + Vector2.DOWN*0.7
		ray = slideDir*17
		query = PhysicsRayQueryParameters2D.create(pos, pos+ray)
		result = space_state.intersect_ray(query)
		if(result.has("normal")):
			if(result["normal"].y >= Globals.NORMAL_DIAG):
				entity.body.velocity = slideDir.rotated(result["normal"].angle()-Globals.PI2)*200
			else:
				entity.goAnimate("entity_crate/sfx_hitwall")
				goto("crate_idle")
		else:
			entity.body.velocity = slideDir*200
	#shitty quick-fix incoming
	pos = entity.body.position + Vector2.DOWN*1
	ray = slideDir*17
	query = PhysicsRayQueryParameters2D.create(pos, pos+ray)
	result = space_state.intersect_ray(query)
	pos = entity.body.position + Vector2.UP*1
	ray = slideDir*17
	query = PhysicsRayQueryParameters2D.create(pos, pos+ray)
	var result2 = space_state.intersect_ray(query)
	if(result.has("normal") && !result2.has("normal") && result["normal"].y > -Globals.NORMAL_DIAG):
		entity.body.position.y -= 0.5
	#shitty quick-fix over
	pos = entity.body.position + Vector2.UP*0.7
	ray = Vector2.DOWN*3
	query = PhysicsRayQueryParameters2D.create(pos, pos+ray)
	result = space_state.intersect_ray(query)
	if(result.has("position")):
		entity.body.position.y = result["position"].y
	super.act(delta)
