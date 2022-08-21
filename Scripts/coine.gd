extends AnimatedSprite

enum type {GameObject, HudElement}
export (type) var coin_type = type.GameObject


func _ready() -> void:
	if coin_type == type.GameObject:
		var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
		var destination_position = Global.coin_hud_position
#		yield(get_tree().create_timer(.5), "timeout")
		tween.tween_property(self, 'global_position', destination_position, 2)
		tween.connect("finished", self, '_on_tweening_is_finished')


func _on_tweening_is_finished():
	queue_free()
