extends Label

var info_str = "Horizontal Power: %d\n     Vertical Power: %d ( %s )\n            Spin Level: %d ( %s )"

func update_text(list):
	text = info_str % list
