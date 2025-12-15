extends Control

@export var start_button : Button
@export var transition : Transitor

func _on_button_pressed() -> void:
	transition.end()
	await transition.end_done
	print("hello")
	get_tree().change_scene_to_file("res://Scenes/programming.tscn")
