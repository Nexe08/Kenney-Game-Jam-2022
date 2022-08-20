extends KinematicBody2D

export var Gravity: float = 200

onready var velocity: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)


func _apply_gravity(dt: float) -> void:
	velocity.y += Gravity * dt


# -- GLOBAL FUNC (GET CALLED IN PHYSICS PROCESS FUNC BY CALLER SCRIPT)
func pick_up(at_position: Vector2):
	global_position.x = lerp(global_position.x, at_position.x, 8 * get_physics_process_delta_time())
	global_position.y = lerp(global_position.y, at_position.y, 8 * get_physics_process_delta_time())
