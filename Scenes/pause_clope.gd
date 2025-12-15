extends Node2D
@export var Animateur : AnimationPlayer
var cigarette_allumé = false

func _input(event): 
	if event.is_action_pressed("allumer") and cigarette_allumé == false:
		Animateur.play("Allumer_Cigarette")
		cigarette_allumé = true

	if event.is_action_pressed("tirer"):
		Animateur.play("Tirer_Cigarette")
pass


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
