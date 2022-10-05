extends MeshInstance

onready var label = get_node("../Info/Viewport/Label")

func _input(event):
	if event.is_action_pressed("ui_menu"):
		visible = !visible
		label.visible = !label.visible
