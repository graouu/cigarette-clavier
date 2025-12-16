extends CharacterBody2D

var ball : CharacterBody2D

func _ready() -> void:
	ball = get_parent().get_node("Ball")

func _physics_process(_delta: float) -> void:
	if ball.global_position.y < 96:
		global_position.y = 96
	elif ball.global_position.y > 552:
		global_position.y = 552
	else:
		global_position.y = ball.global_position.y
