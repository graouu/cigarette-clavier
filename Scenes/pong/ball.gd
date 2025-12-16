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

func _ready() -> void:
	velocity = Vector2(-SPEED, -2)
	computer_text.text = ""

func _physics_process(_delta: float) -> void:
	var col := move_and_collide(velocity)
	if col:
		var normal := col.get_normal()
		sound.pitch_scale = randf_range(0.9,1.1)
		velocity = velocity.bounce(normal)*1.1
		sound.stream = SoundPong
		sound.play()
	if (global_position.x < 384 or global_position.x > 768):
		velocity = Vector2(0,0)
		SpriteBall.hide()
		SpritePaddle1.hide()
		SpritePaddle2.hide()
		anim.play("load")
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_packed(game_resource.game_array[0])
