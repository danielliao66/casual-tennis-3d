extends MeshInstance

func _input(event):
	if event.is_action_pressed("ui_menu"):
		visible = !visible
