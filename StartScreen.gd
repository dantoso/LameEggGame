extends Control
class_name StartScreen

func _process(_delta):
	if Input.is_anything_pressed():
		get_tree().change_scene_to_file("res://Scenes/Sandbox.tscn")
