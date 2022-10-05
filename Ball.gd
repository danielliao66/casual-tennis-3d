extends KinematicBody

var v = Vector3(0, 5, 25)
var w = Vector3.ZERO
const G = -9.8
var orig_pos = translation
var orig_v = v
var orig_w = w

func _physics_process(delta):
	var collision = move_and_collide(v * delta);
	rotation_degrees += w
	if collision:
		var collider = collision.get_collider()
		if collider == $"../Court":
			v.y = -v.y
		elif collider == $"../Player" or collider == $"../Computer":
			var v_hori_abs = 6 * collider.hori_level
			var theta = collider.rotation.y
			if theta != 0:
				v.x = -cos(theta) * v_hori_abs
				v.z = sin(theta) * v_hori_abs
				w = Vector3(sin(theta), 0, cos(theta)) * collider.spin_level
				var v_rel = collider.v_inst - v
				w.y = -(v_rel.x * sin(theta) + v_rel.z * cos(theta))
				v *= (theta / abs(theta))
				w *= (theta / abs(theta))
				if collider == $"../Computer":
					v = -v
					w = -w
					collider.made_choice = false
			v.y = 10 * collider.vert_level
			var dv_xz = Vector3(-v.y * w.z , -v.z * w.x + v.x * w.z, v.y * w.x) * 0.05
			var dv_y = Vector3(v.z, 0, -v.x) * w.y * 0.01
			if collider.w_y_inst < 0:
				dv_y.x += 1.5
			elif collider.w_y_inst > 0:
				dv_y.x -= 1.5
			v += dv_xz + dv_y
	v.y += G * delta
	if translation.z > 50 or translation.z < -50 or translation.x > 30 or translation.x < -30 or Input.is_action_pressed("ui_restart"):
		translation = orig_pos
		v = orig_v
		w = orig_w
	
