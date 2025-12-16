extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = 0
var SoundStepPlaying = false
var SoundOutPlaying = false
@export var transition : Transitor
@onready var game_resource : GameResource = load("res://Assets/GameScenes.tres")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var SoundStep : AudioStream = preload("res://Assets/Step.mp3")
@onready var SoundDoorOpen : AudioStream = preload("res://Assets/doorOpen.mp3")
@onready var SoundDoorClose : AudioStream = preload("res://Assets/doorClose.mp3")
@export var sound : AudioStreamPlayer
@export var scene_id : int

func _ready() -> void:
	transition.beginning()
	# maybe add to the black screen transition
	sound.stream = SoundDoorOpen
	sound.play()
	await sound.finished

func soundWalking():
	SoundStepPlaying = true
	sound.pitch_scale = randf_range(0.8,1.2)
	sound.stream = SoundStep
	sound.play()
	await sound.finished
	SoundStepPlaying = false

func soundOut():
	SoundOutPlaying = true
	sound.stream = SoundDoorClose
	sound.play()
	await sound.finished

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = abs(direction * SPEED)
		animated_sprite_2d.play("Walking")
		# Walking sound
		if SoundStepPlaying == false:
			soundWalking()
		if position.x >= 500:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if SoundOutPlaying == false:
				soundOut()
				transition.end()
				await transition.end_done
				get_tree().change_scene_to_packed(game_resource.game_array[scene_id+1])
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.play("Idle")

	move_and_slide()
