extends RigidBody2D
class_name Egg

@export var turnIntensity: = 500.0
@export var acceleration: = 250.0
@export var jump: = 500

func _physics_process(delta: float) -> void:
	var input: = Input.get_vector("left", "right", "up", "down")
	apply_torque(input.length() * turnIntensity * input.x)
	apply_central_force(Vector2(acceleration * input.x, 0))


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		apply_impulse(Vector2(0, -jump))
