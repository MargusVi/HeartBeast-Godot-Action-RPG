extends CharacterBody2D

var speed = 100
const acceleration = 10
const friction = 10

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_direction != Vector2.ZERO:
		velocity += input_direction * acceleration
		velocity = velocity.limit_length(speed)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)

func _physics_process(_delta):
	get_input()
	move_and_slide()
