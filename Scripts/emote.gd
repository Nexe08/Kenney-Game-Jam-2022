extends Sprite


onready var anim = $AnimationPlayer


func apear():
	anim.play("appear")


func hold():
	anim.play("hold")


func disapear():
	anim.play("disappear")

