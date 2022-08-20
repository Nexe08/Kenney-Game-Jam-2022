extends Area2D

export (NodePath) var togglable_object

onready var machine = get_node(togglable_object)

onready var togglable: bool = true


func press_me():
	if not togglable:
		return
	
	togglable = false
	$Timer.stop()
	$Timer.start()
	
	if machine and is_instance_valid(machine):
		machine.start_production()


func _on_Timer_timeout() -> void:
	togglable = true
