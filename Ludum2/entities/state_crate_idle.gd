class_name State_Crate_Idle
extends State

var justSpawned = 3
var soundPlayed = false

func name():
	return "crate_idle"

func enter(_msg := {}):
	super.enter(_msg)
	soundPlayed = false
func exit():
	super.exit()

func act(delta):
	if(entity.body.get_world_2d() == null): return
	entity.body.velocity.x = 0
	if(entity.floorNormal != null && entity.body.velocity.y > 0):
		if(!soundPlayed):
			if(justSpawned == 0): entity.goAnimate("entity_crate/sfx_hitwall")
			soundPlayed = true
		entity.body.velocity.y = 0
	else:
		entity.body.velocity.y += Globals.GRAVITY
	var space_state = entity.body.get_world_2d().direct_space_state
	var pos = entity.body.position + Vector2.UP*0.7 + Vector2.RIGHT*15.7
	var ray = Vector2.DOWN*16
	var query = PhysicsRayQueryParameters2D.create(pos, pos+ray)
	var result = space_state.intersect_ray(query)
	if(result.has("normal") && result["normal"].y > -1):
		#print(result["normal"])
		entity.body.velocity = entity.body.velocity.rotated(result["normal"].angle()+PI)
	else:
		pos = entity.body.position + Vector2.UP*0.7 + Vector2.LEFT*15.7
		ray = Vector2.DOWN*16
		query = PhysicsRayQueryParameters2D.create(pos, pos+ray)
		result = space_state.intersect_ray(query)
		if(result.has("normal") && result["normal"].y > -1):
			#print(result["normal"])
			entity.body.velocity = entity.body.velocity.rotated(result["normal"].angle()+PI)
	super.act(delta)
	if(justSpawned > 0): justSpawned -= 1
