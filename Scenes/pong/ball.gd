extends CharacterBody2D

@onready var game_resource : GameResource = load("res://Assets/GameScenes.tres")
const SPEED = 5
@export var sound : AudioStreamPlayer
@onready var SoundPong : AudioStream = preload("res://Assets/PongSound.mp3")

func _ready() -> void:
	velocity = Vector2(-SPEED, 0)

func _physics_process(_delta: float) -> void:
	var col := move_and_collide(velocity)
	if col:
		var normal := col.get_normal()
		velocity = velocity.bounce(normal)*1.1
		sound.stream = SoundPong
		sound.play()
	if (global_position.x < 0 or global_position.x > 1152):
		velocity = Vector2(0,0)
		get_tree().change_scene_to_packed(game_resource.game_array[0])
