extends Control

@export var start_button : Button
@export var quit_button : Button
@export var transition : Transitor

@onready var game_resource : GameResource = load("res://Assets/GameScenes.tres")

func _ready() -> void:
	transition.beginning()

func _on_start_button_pressed() -> void:
	transition.end()
	await transition.end_done
	print("hello")
	get_tree().change_scene_to_packed(game_resource.game_array[0])


func _on_button_quit_pressed() -> void:
	get_tree().quit()
