extends Control

@export var start_button : Button
@export var transition : Transitor

@onready var game_resource : GameResource = load("res://Assets/GameScenes.tres")

func _on_button_pressed() -> void:
	transition.end()
	await transition.end_done
	print("hello")
	get_tree().change_scene_to_packed(game_resource.game_array[0])
