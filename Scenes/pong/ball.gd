extends CharacterBody2D

@onready var game_resource : GameResource = load("res://Assets/GameScenes.tres")
const SPEED = 2
@export var sound : AudioStreamPlayer
@onready var SoundPong : AudioStream = preload("res://Assets/PongSound.mp3")
@export var SpriteBall : CharacterBody2D
@export var SpritePaddle1 : CharacterBody2D
@export var SpritePaddle2 : CharacterBody2D
@export var computer_text : RichTextLabel
@export var code_lines : String
@export var anim : AnimationPlayer
@export var gameover : RichTextLabel

var done : bool = false
var intro_done : bool = false

func _ready() -> void:
	velocity = Vector2(-SPEED, -2)
	computer_text.text = ""

func _physics_process(_delta: float) -> void:
	if intro_done:
		var col := move_and_collide(velocity)
		if col:
			var normal := col.get_normal()
			sound.pitch_scale = randf_range(0.9,1.1)
			velocity = velocity.bounce(normal)*1.1
			sound.stream = SoundPong
			sound.play()
		if (global_position.x < 384 or global_position.x > 768) and done==false:
			done = true
			velocity = Vector2(0,0)
			SpriteBall.hide()
			SpritePaddle1.hide()
			SpritePaddle2.hide()
			anim.play("load")
			await get_tree().create_timer(5).timeout
			gameover.hide()
			var first_level = preload("res://Scenes/programming1.tscn").instantiate()
			get_tree().root.add_child(first_level)



func _on_entry_anim_animation_finished(_anim_name: StringName) -> void:
	intro_done = true
