extends CharacterBody2D

@export var ball : CharacterBody2D


func _ready() -> void:
	ball = get_parent().get_node("Ball")

func _physics_process(_delta: float) -> void:
	if ball.global_position.y < 130:
		global_position.y = 130
	elif ball.global_position.y > 384:
		global_position.y = 384
	else:
		global_position.y = ball.global_position.y
