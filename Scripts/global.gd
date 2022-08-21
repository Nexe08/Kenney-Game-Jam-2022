extends Node

var game_scene
var BoxSpawner

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


func buying_fule():
	var remaining_fule: float
	var coin: int
	if game_scene and is_instance_valid(game_scene):
		coin = game_scene.get_coin()
	
	# increase fule
	if BoxSpawner and is_instance_valid(BoxSpawner):
		remaining_fule = BoxSpawner.get_remaining_fule()
		if coin > 0 and remaining_fule > 1:
			if game_scene and is_instance_valid(game_scene):
				game_scene.set_coint_count(-1)
				BoxSpawner.update_fule_count(1)
