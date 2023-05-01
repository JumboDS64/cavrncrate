class_name Sensor
extends Area2D

var state
var results = []
var shape

func init(_state):
	state = _state
	shape = get_child(0)

func open():
	state.entity.body.add_child(self)
	#print(window.entity," add ",self)
func close():
	state.entity.body.remove_child(self)
	#print(window.entity," rem ",self)

func sense():
	results = []
	for i in get_overlapping_bodies():
		if i != state.entity.body:
			var p = item(i)
			if cond(p) && results.find(p) == -1:
				results.append(p)
	return results

func senseRay(): #only use if shape is a ray
	var col = get_child(0)
	var space_state = get_world_2d().direct_space_state
	var pos = state.entity.body.transform*col.position
	var ray = col.transform.basis*Vector3.BACK*col.shape.length
	#print(ray)
	var query = PhysicsRayQueryParameters3D.create(pos, pos+ray)
	var result = space_state.intersect_ray(query)
	#print(result)
	if(result.has("collider")):
		var p = item(result["collider"])
		if cond(p):
			results = result
			return results
			#entity.goto("player_push",{"grab":e,"normal":result["normal"],"position":result["position"]})
	results = null
	return results

func has_results():
	return results != null && results != []

func item(i):
	return i.get_parent()
func cond(p):
	return true

func get_shape():
	return shape
func get_shape_position():
	return get_shape().global_position - self.global_position
