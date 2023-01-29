extends Label

var info_str = "Horizontal Power: %f\n     Vertical Power: %f ( %s )\n             Spin Type: %s\n                Rotation: %f ( %s )"

func update_text(list):
	text = info_str % list
