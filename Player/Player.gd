extends CharacterBody2D

var speed = 100
const acceleration = 10
const friction = 10

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_direction != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_direction)
		animation_tree.set("parameters/Run/blend_position", input_direction)
		animation_state.travel("Run")
		velocity += input_direction * acceleration
		velocity = velocity.limit_length(speed)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction)

func _physics_process(_delta):
	get_input()
	move_and_slide()
