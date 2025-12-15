extends Control

@export var computer_text : RichTextLabel
@export var code_lines : String
@export var compilation_button : Button
@export var button_container : HBoxContainer

@onready var code_size = code_lines.length()

var number_of_inputs : int = 0
var done : bool = false

func _ready() -> void:
	computer_text.text = ""

func _input(event: InputEvent) -> void:
	if event is not InputEventMouseMotion and event.is_pressed() and !done:
		number_of_inputs+=5
		computer_text.text = code_lines.substr(0,number_of_inputs)
		if number_of_inputs >= code_size:
			compilation_button.show()

func _on_button_pressed() -> void:
	done = true
	compilation_button.hide()
	computer_text.get_child(0).play("compiling")

func _on_keep_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/programming.tscn")
