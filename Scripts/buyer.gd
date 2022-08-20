extends KinematicBody2D


export var gravity: float = 500

var velocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func pay_payment():
	pass


func _on_Shop_body_entered(body: Node) -> void:
	if body.is_in_group("Box"):
		body.get_bought()
		pay_payment()
