extends CharacterBody2D

var speed = 100
const acceleration = 10
const friction = 10

@onready var animation_player = $AnimationPlayer

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_direction != Vector2.ZERO:
		if input_direction.x > 0:
			animation_player.play("RunRight")
		else:
			animation_player.play("RunLeft")
		velocity += input_direction * acceleration
		velocity = velocity.limit_length(speed)
	else:
		animation_player.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, friction)

func _physics_process(_delta):
	get_input()
	move_and_slide()
