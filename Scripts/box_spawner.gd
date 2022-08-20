extends Node2D

onready var spawn_position = $SpawnPosition
onready var box_path = preload("res://Prefabe/Box.tscn")



func _on_SpawnTimer_timeout() -> void:
	var instance = box_path.instance()
	instance.global_position = spawn_position.global_position
	get_parent().add_child(instance)
