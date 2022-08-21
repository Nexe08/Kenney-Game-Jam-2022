extends Node2D

export (Color) var main_menu_disabled_color

onready var game_scene = $GameScene
onready var main_menu = $CanvasLayer/ColorRect


func _ready() -> void:
	get_tree().paused = true
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("pick"):
		get_tree().paused = false
		main_menu.modulate = main_menu_disabled_color
