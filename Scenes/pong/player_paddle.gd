extends CharacterBody2D


const SPEED = 200.0

func getWider() -> float:
	return Input.get_action_strength("down") - Input.get_action_strength("up")

func _physics_process(_delta: float) -> void:
	var direction : Vector2=Vector2(0, getWider())
	velocity = direction * SPEED
	move_and_slide()
