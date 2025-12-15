extends Node2D
func _input(event): 
	if event.is_action_pressed("allumer"):
		$Animator.play("Allumer_Clope")

	if event.is_action_pressed("tirer"):
		$Animator.play("Tirer_Clope")
pass


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
