extends RigidBody2D
class_name Egg

@export var turnIntensity: = 500.0

func _physics_process(delta: float) -> void:
	var input: = Input.get_vector("left", "right", "up", "down")
	print(input)
	apply_torque(input.length() * turnIntensity * input.x)
