extends Node

var game_scene

var coin_hud_position: Vector2

onready var coin_path: PackedScene = preload("res://Prefabe/Coine.tscn")


func _ready() -> void:
	randomize()


func buyer_bought_item(value):
	if game_scene and is_instance_valid(game_scene):
		game_scene.set_coint_count(value)


func fule_is_update_in_box_spawner(value, max_value):
	if game_scene and is_instance_valid(game_scene):
		game_scene.set_fule_value_in_fule_indicator(value, max_value)
