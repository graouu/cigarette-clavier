class_name Transitor extends ColorRect

signal end_done

@onready var anim = $AnimationPlayer

func beginning():
	anim.play("appear")
	
func end():
	anim.play("disappear")
	await anim.animation_finished
	end_done.emit()
