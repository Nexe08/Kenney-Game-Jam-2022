extends Node2D

export var coin: int

onready var coin_count_text = $"%CoinCount"
onready var coin_in_hud = $"%CoineInHud"

func _ready() -> void:
	Global.game_scene = self
	Global.coin_hud_position = $"%CoineInHud".global_position

func set_coint_count(value):
	coin += value
	coin_count_text.text = String(coin)
	
