extends Node2D

onready var spawn_position = $SpawnPosition
onready var box_path = preload("res://Prefabe/Box.tscn")


func spawn_box():
	var instance = box_path.instance()
	instance.global_position = spawn_position.global_position
	get_parent().add_child(instance)


func start_production():
	spawn_box()
