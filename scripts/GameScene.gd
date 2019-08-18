extends Node2D

func _ready():
	randomize()

func _process(delta):
	if Input.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
