extends Node2D

@export var Animateur : AnimationPlayer
@export var bar : ProgressBar
@export var timer : Timer
@export var scene_id : int
@onready var game_resource : GameResource = load("res://Assets/GameScenes.tres")
@export var transition : Transitor
@export var pixelisation : ColorRect
@export var smoke : ColorRect
@export var sprite : AnimatedSprite2D

@onready var shader = pixelisation.material
@onready var shader_smoke = smoke.material

var cigarette_allumé = false
@export var pixelisation_float : float
@export var next_pixelation_float : float
var smoke_float = 0.0

func _ready() -> void:
	transition.beginning()
	shader_smoke.set_shader_parameter("fire_alpha", smoke_float)
	shader.set_shader_parameter("pixelation", pixelisation_float)

func _process(_delta: float) -> void:
	bar.value = timer.time_left

func _input(event): 
	if event.is_action_pressed("allumer") and !Animateur.is_playing():
		if cigarette_allumé:
			Animateur.play("Tirer_Cigarette")
			sprite.play("Tire")
			var tween = get_tree().create_tween()
			tween.tween_method(func(value): shader.set_shader_parameter("pixelation", value),  pixelisation_float, next_pixelation_float, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_method(func(value): shader.set_shader_parameter("pixelation", value),  next_pixelation_float, pixelisation_float+0.001, 2.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_method(func(value): shader_smoke.set_shader_parameter("fire_alpha", value),  smoke_float, smoke_float+0.2, 2).set_trans(Tween.TRANS_BOUNCE)
			smoke_float+=0.2
			pixelisation_float += 0.002
			next_pixelation_float += 0.002
			
			await Animateur.animation_finished
			if !timer.time_left<=3:
				timer.start(timer.time_left-3)
		else:
			Animateur.play("Allumer_Cigarette")
			sprite.play("Allume")
			var tween = get_tree().create_tween()
			tween.tween_method(func(value): shader_smoke.set_shader_parameter("fire_alpha", value),  smoke_float, smoke_float+0.2, 2).set_trans(Tween.TRANS_BOUNCE)
			smoke_float+=0.2
			cigarette_allumé = true
			timer.start()
pass


func _on_timer_timeout():
	if scene_id == 11:
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween.tween_method(func(value): shader.set_shader_parameter("pixelation", value),  pixelisation_float, 1, 5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		transition.self_modulate.a = 0
		transition.show()
		tween2.tween_property(transition, "self_modulate:a", 1,5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		await get_tree().create_timer(6).timeout
		get_tree().change_scene_to_packed(game_resource.game_array[scene_id+1])
	else:
		transition.end()
		await transition.end_done
		get_tree().change_scene_to_packed(game_resource.game_array[scene_id+1])
