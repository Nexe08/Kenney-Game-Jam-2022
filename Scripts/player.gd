extends KinematicBody2D


export var MaxMovementSpeed: float = 100
export var Gravity: float = 800

onready var velocity: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	velocity.x = MaxMovementSpeed * _horizontal_input_direction()
	_apply_gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)


func _apply_gravity(dt: float) -> void:
	velocity.y += Gravity * dt


func _horizontal_input_direction():
	return int(Input.get_action_strength("right") - Input.get_action_strength("left"))
