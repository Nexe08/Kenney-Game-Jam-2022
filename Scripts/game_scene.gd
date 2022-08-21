extends Node2D

export var coin: int

onready var coin_count_text = $"%CoinCount"
onready var coin_in_hud = $"%CoineInHud"
onready var fule_indicator = $"%FuleIndicator"

var low_in_fule: bool = false


func _ready() -> void:
	Global.game_scene = self
	Global.coin_hud_position = $"%CoineInHud".global_position


func _process(delta: float) -> void:
	if low_in_fule:
		fule_indicator.rect_rotation = rand_range(-.8, 8)
	


func set_coint_count(value):
	coin += value
	coin_count_text.text = String(coin)

func set_fule_value_in_fule_indicator(value, max_value):
	fule_indicator.value = value
	fule_indicator.max_value = max_value
	if (fule_indicator.value / fule_indicator.max_value) * 100 <= 30:
		low_in_fule = true
		return
	low_in_fule = false
#		fule_indicator.rect_rotation = rand_range(-.8, 8)
	
