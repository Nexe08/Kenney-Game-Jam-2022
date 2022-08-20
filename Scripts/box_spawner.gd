extends Node2D

export var fule: float = 10


onready var box_path = preload("res://Prefabe/Box.tscn")

onready var fule_indicator = $FuleIndicator
onready var spawn_position = $SpawnPosition

const max_fule: int = 10


func _ready() -> void:
	fule_indicator.max_value = max_fule
	fule_indicator.value = fule


func spawn_box():
	if fule <= 0:
		return
	
	var instance = box_path.instance()
	instance.global_position = spawn_position.global_position
	get_parent().add_child(instance)
	fule -= rand_range(1, 1.7)
	fule_indicator.value = fule


func start_production():
	spawn_box()
