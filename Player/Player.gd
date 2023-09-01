extends CharacterBody2D

const speed = 100
const acceleration = 10
const friction = 10

enum{
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true

func _process(_delta):
	match state:
		MOVE:
			move_state()
		ROLL:
			pass
		ATTACK:
			attack_state()

func move_state():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_direction != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_direction)
		animation_tree.set("parameters/Run/blend_position", input_direction)
		animation_tree.set("parameters/Attack/blend_position", input_direction)
		animation_state.travel("Run")
		velocity += input_direction * acceleration
		velocity = velocity.limit_length(speed)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	move_and_slide()
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
func attack_state():
	velocity = Vector2.ZERO
	animation_state.travel("Attack")
	
func attack_animation_finished():
	state = MOVE
