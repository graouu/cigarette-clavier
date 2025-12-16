extends Node2D

@export var Animateur : AnimationPlayer
@export var bar : ProgressBar
@export var timer : Timer
@export var scene_id : int
@onready var game_resource : GameResource = load("res://Assets/GameScenes.tres")
@export var transition : Transitor

var cigarette_allumé = false

func _process(_delta: float) -> void:
	bar.value = timer.time_left

func _input(event): 
	if event.is_action_pressed("allumer") and !Animateur.is_playing():
		if cigarette_allumé:
			Animateur.play("Tirer_Cigarette")
			await Animateur.animation_finished
			timer.start(timer.time_left-3)
		else:
			Animateur.play("Allumer_Cigarette")
			cigarette_allumé = true
			timer.start()
pass


func _on_timer_timeout():
	transition.end()
	await transition.end_done
	get_tree().change_scene_to_packed(game_resource.game_array[scene_id+1])
