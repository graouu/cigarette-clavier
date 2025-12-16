extends Control

@export var computer_text : RichTextLabel
@export var code_lines : String
@export var compilation_button : Button
@export var button_container : Control
@export var sound : AudioStreamPlayer
@export var transition : Transitor
@export var scene_id : int


@onready var game_resource : GameResource = load("res://Assets/GameScenes.tres")

@onready var code_size = code_lines.length()
@onready var keyboard_click : AudioStream = preload("res://Assets/typing.mp3")
@onready var mouse_click : AudioStream = preload("res://Assets/computer-mouse-click-352734.mp3")

var number_of_inputs : int = 0
var done : bool = false

func _ready() -> void:
	if self==get_tree().current_scene:
		transition.beginning()
	else:
		transition.self_modulate.a = 0
	computer_text.text = ""

func _input(event: InputEvent) -> void:
	if event is not InputEventMouseMotion and event.is_pressed() and !done:
		number_of_inputs+=5
		computer_text.text = code_lines.substr(0,number_of_inputs)
		if number_of_inputs >= code_size:
			compilation_button.show()
		else:
			sound.pitch_scale = randf_range(0.8,1.2)
			sound.stream = keyboard_click
			sound.play()

func _on_button_pressed() -> void:
	done = true
	compilation_button.hide()
	sound.stream = mouse_click
	sound.play()
	computer_text.get_child(0).play("compiling")

func _on_keep_pressed() -> void:
	button_container.hide()
	sound.stream = mouse_click
	sound.play()
	transition.end()
	await transition.end_done
	get_tree().change_scene_to_packed(game_resource.game_array[scene_id])


func _on_leave_pressed() -> void:
	button_container.hide()
	sound.stream = mouse_click
	sound.play()
	transition.end()
	await transition.end_done
	if game_resource.game_array.size() == scene_id+1:
		get_tree().change_scene_to_packed(game_resource.game_array[0])
	else:
		get_tree().change_scene_to_packed(game_resource.game_array[scene_id+1])
	
