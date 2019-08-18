extends ColorRect

func set_health(health, max_health):
	$GreenBar.rect_size.x = float(health) / max_health * rect_size.x