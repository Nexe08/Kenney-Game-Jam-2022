extends KinematicBody2D

export var Gravity: float = 200

onready var velocity: Vector2 = Vector2.ZERO
onready var pickedup: bool = false

onready var collision_shape = $CollisionShape2D


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)


func _apply_gravity(dt: float) -> void:
	if pickedup:
		return
	velocity.x = 0
	velocity.y += Gravity * dt


# -- GLOBAL FUNC (GET CALLED IN PHYSICS PROCESS FUNC BY CALLER SCRIPT)
func pickup(at_position: Vector2):
	pickedup = true
	collision_shape.call_deferred("set_disabled", true)
	global_position.x = lerp(global_position.x, at_position.x, 8 * get_physics_process_delta_time())
	global_position.y = lerp(global_position.y, at_position.y, 8 * get_physics_process_delta_time())


func release(at_position: Vector2):
	pickedup = false
	collision_shape.call_deferred("set_disabled", false)
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position", at_position, .5)
