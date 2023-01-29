extends KinematicBody

var mouse_pos
var rot_ang = 0
var rot_sort = "Undefined"
var hori_level = 0
var vert_level = 18
var spin_level = 7
var v_inst = Vector3.ZERO
var w_y_inst = 0
var w = 0
var vert_sort = "Up"
var spin_sort = "Top"
var list = [hori_level, vert_level, vert_sort, spin_sort, rot_ang, rot_sort]
onready var ball = get_node("../Ball")
onready var label = get_node("../Info/Viewport/Label")
onready var camera = get_node("../Camera")
onready var info = get_node("../Info")
onready var menu = get_node("../Menu")

func _ready():
	label.update_text(list)

func _input(event):
	if event.is_action_pressed("ui_spin"):
		spin_level *= -1
		if spin_level > 0:
			spin_sort = "Top"
		else:
			spin_sort = "Back"
		list[3] = spin_sort
		label.update_text(list)
	elif event.is_action_pressed("ui_y_pos"):
		rotation_degrees.y = 150
		hori_level = 0
	elif event.is_action_pressed("ui_y_neg"):
		rotation_degrees.y = -150
		hori_level = 0
	elif event.is_action_released("ui_y_pos"):
		w = -15
	elif event.is_action_released("ui_y_neg"):
		w = 15

func _physics_process(delta):
	mouse_pos = get_viewport().get_mouse_position()
	var v = Vector3.ZERO
	if Input.is_action_pressed("ui_y_pos"):
		if hori_level < 25:
			hori_level += 1.4
		rot_ang = (150 * (1018 - mouse_pos.x) + 30 * (mouse_pos.x - 5)) / 1013
		if mouse_pos.x < 511.5:
			rot_sort = "Left"
		else:
			rot_sort = "Right"
		determine()
	if Input.is_action_pressed("ui_y_neg"):
		if hori_level < 25:
			hori_level += 1.4
		rot_ang = (-30 * (1018 - mouse_pos.x) + (-150) * (mouse_pos.x - 5)) / 1013
		if mouse_pos.x < 511.5:
			rot_sort = "Left"
		else:
			rot_sort = "Right"
		determine()
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
	camera.translation = translation + Vector3(0, 5, -10)
	info.translation = translation + Vector3(-20, -3, 40)
	menu.translation = translation + Vector3(30, 4, 42)
	rotation_degrees.y += w
	var rotation_range = abs(rotation_degrees.y)
	if (rotation_range > 60 and w * rotation_degrees.y > 0):
		rotation_degrees.y = 0
		w = 0

func determine():
	vert_level = (25 * (594 - mouse_pos.y) + (-15) * (mouse_pos.y - 5)) / 589
	list[0] = hori_level
	list[1] = vert_level
	if vert_level > 0:
		vert_sort = "Up"
	else:
		vert_sort = "Down"
	list[2] = vert_sort
	list[4] = rot_ang
	list[5] = rot_sort
	label.update_text(list)
