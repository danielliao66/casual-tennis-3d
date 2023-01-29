extends KinematicBody

var made_choice
var hori_level = 20
var vert_level = 15
var spin_level = 7
var rot_ang = 90
var v_inst = Vector3.ZERO
var w_y_inst = 0
onready var ball = get_node("../Ball")
onready var player = get_node("../Player")
onready var racquet = get_node("CollisionShape")
var rng = RandomNumberGenerator.new()
var h_diff
var rot_deg

func _physics_process(delta):
	rot_deg = rotation_degrees.y
	if rot_deg < 0:
		rot_deg += 180
	else:
		rot_deg -= 180
	if ball.v.z > 0:
		v_inst = ball.translation + ball.v * delta * 15 - racquet.global_translation
		v_inst.y *= 0
		v_inst *= 15 * sqrt(2) / v_inst.length()
		if ball.v.y < 0:
			h_diff = ball.translation.y - translation.y
			v_inst.y = 12 * h_diff / abs(h_diff)
			if abs(h_diff) < 1:
				translation.z = ball.translation.z
		move_and_collide(v_inst * delta);
		if translation.x > 30:
			translation.x = 30
		elif translation.x < -30:
			translation.x = -30
		if translation.y > 7:
			translation.y = 7
		if translation.z < 5:
			translation.z = 5
		elif translation.z > 60:
			translation.z = 60
		if (not made_choice):
			#hori_level = ball.v.z;
			#vert_level = ball.v.y;
			rng.randomize()
			if rng.randi_range(0, 1) == 1:
				rotation_degrees.y = -30
			else:
				rotation_degrees.y = -330
			rng.randomize()
			rot_ang = rng.randi_range(60, 120)
			made_choice = true
	rotation_degrees.y += w_y_inst
	rot_deg += w_y_inst
	var rotation_range = abs(rot_deg)
	if (rotation_range > 60 and w_y_inst * rot_deg > 0):
		rotation_degrees.y = -180
		w_y_inst = 0
