extends Node3D

var direction = Vector3.FORWARD

func _physics_process(delta):
	var look_direction = Input.get_vector("look_right", "look_left", "look_down", "look_up")
	var current_velocity = get_parent().get_linear_velocity()
	if (look_direction.length() > 0.1):
		var focus_direction = Vector3(look_direction.x, direction.y, direction.z)
		direction = lerp(direction, focus_direction.normalized(), 2.5 * delta)
	elif (current_velocity.length() > 1):
		current_velocity.y = 0
		direction = lerp(direction, -current_velocity.normalized(), 2.5 * delta)
	global_transform.basis = lerp(global_transform.basis, get_rotation_from_direction(direction), 2.5 * delta)
	
func get_rotation_from_direction(look_direction: Vector3) -> Basis:
	look_direction = look_direction.normalized()
	var x_axis = look_direction.cross(Vector3.UP)
	return Basis(x_axis, Vector3.UP, -look_direction)
