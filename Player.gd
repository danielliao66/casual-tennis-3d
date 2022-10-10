extends KinematicBody

var hori_level = 5
var vert_level = 1
var spin_level = 1
var v_inst = Vector3.ZERO
var w_y_inst = 0
var w = 0
var vert_sort = "Lob"
var spin_sort = "Drive"
var list = [hori_level, int(abs(vert_level)), vert_sort, int(abs(spin_level)), spin_sort]
onready var ball = get_node("../Ball")
onready var label = get_node("../Info/Viewport/Label")
onready var camera = get_node("../Camera")

func _ready():
	label.update_text(list)

func _input(event):
	if event.is_action_pressed("ui_hor_pos"):
		if hori_level < 5:
			hori_level += 1
			list[0] = hori_level
			label.update_text(list)
	if event.is_action_pressed("ui_hor_neg"):
		if hori_level > 1:
			hori_level -= 1
			list[0] = hori_level
			label.update_text(list)
	if event.is_action_pressed("ui_ver_pos"):
		if vert_level < 3:
			vert_level += 1
			if vert_level == 0:
				vert_sort = "Flat"
			elif vert_level == 1:
				vert_sort = "Lob"
			list[1] = int(abs(vert_level))
			list[2] = vert_sort
			label.update_text(list)
	if event.is_action_pressed("ui_ver_neg"):
		if vert_level > -3:
			vert_level -= 1
			if vert_level == 0:
				vert_sort = "Flat"
			elif vert_level == -1:
				vert_sort = "Smash"
			list[1] = int(abs(vert_level))
			list[2] = vert_sort
			label.update_text(list)
	if event.is_action_pressed("ui_spin_pos"):
		if spin_level == -1:
			spin_level = 1
			spin_sort = "Drive"
		elif spin_level < 3:
			spin_level += 1
		list[3] = int(abs(spin_level))
		list[4] = spin_sort
		label.update_text(list)
	if event.is_action_pressed("ui_spin_neg"):
		if spin_level == 1:
			spin_level = -1
			spin_sort = "Slice"
		elif spin_level > -3:
			spin_level -= 1
		list[3] = int(abs(spin_level))
		list[4] = spin_sort
		label.update_text(list)
	if event.is_action_pressed("ui_y_pos"):
		rotation_degrees.y = 100
	if event.is_action_pressed("ui_y_neg"):
		rotation_degrees.y = -100
	if event.is_action_released("ui_y_pos"):
		w = -15
	if event.is_action_released("ui_y_neg"):
		w = 15

func _physics_process(delta):
	var v = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		v.z = 15
	if Input.is_action_pressed("ui_down"):
		v.z = -15
	if Input.is_action_pressed("ui_left"):
		v.x = 15
	if Input.is_action_pressed("ui_right"):
		v.x = -15
	if Input.is_action_pressed("ui_ascend"):
		v.y = 15
	if Input.is_action_pressed("ui_descend"):
		v.y = -15
	v_inst = v
	w_y_inst = w
	if ball.v.z < 0:
		if translation.z > -5:
			translation.z = -5
	move_and_collide(v * delta)
	camera.translation.x = translation.x
	camera.translation.z = translation.z - 14
	rotation_degrees.y += w
	var rotation_range = abs(rotation_degrees.y)
	if (rotation_range > 60 and w * rotation_degrees.y > 0):
		rotation_degrees.y = 0
		w = 0
