extends Node2D
class_name Sandbox

@onready var egg: = $Egg
@onready var timer: Timer = $DeathTimer
var waitingRetry: = false
var start: = Vector2.ZERO

func _ready() -> void:
	start = egg.global_position
	timer.timeout.connect(
		func():
			waitingRetry = true
	)


func didDie() -> void:
	egg.can_sleep = true
	egg.sleeping = true
	remove_child(egg)
	timer.start()


func _process(delta: float) -> void:
	if waitingRetry:
		if Input.is_anything_pressed():
			print("respawn")
			waitingRetry = false
			egg.global_position = start
			egg.camera.get_parent().remove_child(egg.camera)
			egg.add_child(egg.camera)
			add_child(egg)
			egg.sleeping = false

