extends Node2D

export (NodePath) var emote_position

export var fule: float = 10


onready var box_path = preload("res://Prefabe/Box.tscn")
onready var idea_emote_path = preload("res://Prefabe/EmoteIdea.tscn")
onready var aleart_emote_path = preload("res://Prefabe/EmoteAlert.tscn")
onready var cross_emote_path = preload("res://Prefabe/EmoteCross.tscn")

onready var emote_position_ins = get_node(emote_position)

onready var spawn_position = $SpawnPosition

const max_fule: int = 10


func _ready() -> void:
	Global.BoxSpawner = self


func update_fule_count(value):
	fule += value
	Global.fule_is_update_in_box_spawner(fule, max_fule)


func get_remaining_fule():
	return max_fule - fule


func spawn_box():
	if fule <= 0:
		_spawn_emote(cross_emote_path)
		return
	
	var instance = box_path.instance()
	instance.global_position = spawn_position.global_position
	get_parent().add_child(instance)
	fule -= rand_range(1, 1.7)
	Global.fule_is_update_in_box_spawner(fule, max_fule)
	
	if (fule / max_fule) * 100 <= 30:
		_spawn_emote(aleart_emote_path)
	else:
		_spawn_emote(idea_emote_path)
#	fule_indicator.value = fule


func start_production():
	spawn_box()


func _spawn_emote(path: PackedScene):
	var instance = path.instance()
	if not emote_position_ins or not is_instance_valid(emote_position_ins):
		print_debug("emote positon is not defined. You dumb stupid.")
	instance.global_position = emote_position_ins.global_position
	get_parent().add_child(instance)
