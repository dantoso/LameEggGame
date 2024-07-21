extends RigidBody2D
class_name Egg

@export var turnIntensity: = 500.0
@export var acceleration: = 250.0
@export var jump: = 500
@export var resistance: = 500
@export var coyoteTime: = 0.2

@onready var timer: Timer = $Timer
@onready var deadSprite: Sprite2D = $DeadSprite
@onready var camera: Camera2D = $Camera2D
@onready var parent: Sandbox = get_parent()

var prevVelocity: = Vector2.ZERO
var currentVelocity: = Vector2.ZERO
var lastCollision: KinematicCollision2D = null
var canJump: = true

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 18
	
	remove_child(deadSprite)
	
	timer.wait_time = coyoteTime
	timer.timeout.connect(
		func():
			canJump = false
	)

func _physics_process(delta: float) -> void:
	var input: = Input.get_vector("left", "right", "up", "down")
	apply_torque(input.length() * turnIntensity * input.x)
	apply_central_force(Vector2(acceleration * input.x, 0))
	var collision: = move_and_collide(Vector2.ZERO)
	if collision:
		var result: = collision.get_normal().dot(prevVelocity)
		if result * sign(result) > resistance:
			print("Dead: ", result)
			remove_child(camera)
			deadSprite.add_child(camera)
			deadSprite.global_position = global_position
			if deadSprite.get_parent():
				deadSprite.get_parent().remove_child(deadSprite)
			parent.add_child(deadSprite)
			can_sleep = true
			parent.didDie()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") && canJump:
		canJump = false
		apply_impulse(Vector2(0, -jump))


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in state.get_contact_count():
		if state.get_contact_local_normal(i).y <= -0.6:
			canJump = true
			timer.start()
			break
	
	prevVelocity = currentVelocity
	currentVelocity = state.linear_velocity

















