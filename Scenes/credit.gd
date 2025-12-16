extends Node2D

@export var transition : Transitor
@export var text_titre : RichTextLabel
@export var text_noms : RichTextLabel
@export var code_lines1 : String
@export var code_lines2 : String
@export var code_lines3 : String
@export var code_lines4 : String
@export var code_lines5 : String
@export var code_lines6 : String
@export var animG : AnimationPlayer
@export var animGn : AnimationPlayer
@export var animP : AnimationPlayer
@export var animPn : AnimationPlayer
@export var animM : AnimationPlayer
@export var animMn : AnimationPlayer
@export var button : Button
@export var sound : AudioStreamPlayer
@onready var SoundKeyboard : AudioStream = preload("res://Assets/typing.mp3")
@onready var SoundMousse : AudioStream = preload("res://Assets/computer-mouse-click-352734.mp3")
@onready var game_resource : GameResource = load("res://Assets/GameScenes.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.beginning()
	code_lines1 = ""
	code_lines2 = ""
	code_lines3 = ""
	code_lines4 = ""
	code_lines5 = ""
	code_lines6 = ""
	#Animation text
	sound.stream = SoundKeyboard
	animG.play("titreG")
	await animG.animation_finished
	animGn.play("nomsG")
	await animGn.animation_finished
	animP.play("titreP")
	await animP.animation_finished
	animPn.play("nomsP")
	await animPn.animation_finished
	animM.play("titreM")
	await animM.animation_finished
	animMn.play("nomsM")
	await animMn.animation_finished
	#Show button
	button.show()

func _on_button_pressed() -> void:
	sound.stream = SoundMousse
	sound.play()
	transition.end()
	await transition.end_done
	get_tree().change_scene_to_packed(load("res://Scenes/mainmenu.tscn"))
