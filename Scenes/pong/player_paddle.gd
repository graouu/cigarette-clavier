extends CharacterBody2D


const SPEED = 200.0
var displacement : float = 0


func _process(_delta: float) -> void:
	if Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") != 0:
		displacement = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

func _physics_process(_delta: float) -> void:
	var direction : Vector2=Vector2(0, displacement)
	velocity = direction * SPEED
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print(event.position.y-324, "/", position.y)
		if event.position.y-324 < position.y:
			displacement = -1
		elif event.position.y-324 > position.y:
			displacement = 1
