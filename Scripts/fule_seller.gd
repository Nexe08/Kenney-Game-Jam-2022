extends KinematicBody2D


export var gravity: float = 500

var velocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func buy_fule():
	Global.buying_fule()
