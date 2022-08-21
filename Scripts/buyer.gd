extends KinematicBody2D


export var gravity: float = 500

var velocity := Vector2.ZERO
var price_pool = [1,1,1,1,1,1,2,2,2,2,2,3,3]


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func pay_payment():
	var instance = Global.coin_path.instance()
	instance.global_position = global_position
	get_parent().add_child(instance)
	price_pool.shuffle()
	var payment_amount = price_pool[0]
	Global.buyer_bought_item(payment_amount)


func _on_Shop_body_entered(body: Node) -> void:
	if body.is_in_group("Box"):
		body.get_bought()
		pay_payment()
