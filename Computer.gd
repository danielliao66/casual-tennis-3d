extends KinematicBody

var made_choice
var hori_level = 1
var vert_level = 1
var spin_level = 1
var v_inst = Vector3.ZERO
var w_y_inst = 5
onready var ball = get_node("../Ball")
onready var player = get_node("../Player")
onready var racquet = get_node("CollisionShape")
var rng = RandomNumberGenerator.new()

func _physics_process(delta):
	if ball.v.z > 0:
		v_inst = ball.translation - racquet.global_translation
		v_inst.x *= 10
		v_inst.y *= 10
		v_inst.z *= 1e-2
		move_and_collide(v_inst * delta);
		if translation.z < 5:
			translation.z = 5
		if (not made_choice):
			hori_level = ball.v.z / 6;
			vert_level = ball.v.y / 7;
			rng.randomize()
			rotation_degrees.y = rng.randi_range(80, 100)
			if rng.randi_range(0, 1) == 1:
				rotation_degrees.y = -rotation_degrees.y
			made_choice = true
