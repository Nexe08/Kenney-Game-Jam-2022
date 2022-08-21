extends KinematicBody2D


export (float, 0, 10000) var MaxMovementSpeed: float = 100
export (float, 0, 10000) var MaxJumpForce: float = 300
export (float, 0, 10000) var Gravity: float = 800

var detected_box: Node = null
var detected_button: Node = null
var detected_shop: Node = null
var holded_box: Node = null

onready var velocity: Vector2 = Vector2.ZERO
onready var direction: int = -1 # facing direction of character

onready var default_box_detector_position = $BoxDetector.position
onready var default_button_detector_position = $ButtonDetector.position
onready var default_box_placing_position = $BoxPlacingPosition.position
onready var default_holded_box_position = $HoldedBoxPosition.position

onready var box_detector = $BoxDetector
onready var button_detector = $ButtonDetector
onready var box_placing_position = $BoxPlacingPosition
onready var holded_box_position = $HoldedBoxPosition
onready var sprite = $Sprite
onready var guide_sprite = $PlacingPositionGuideSprite


func _physics_process(delta: float) -> void:
	guide_sprite.position.x = lerp(guide_sprite.position.x, box_detector.position.x, 8 * delta)
	guide_sprite.position.y = lerp(guide_sprite.position.y, box_detector.position.y, 8 * delta)
	_handle_movement(delta)
	_apply_gravity(delta)
	_handle_box_holding_and_button_press_and_buying_fule()
	velocity = move_and_slide(velocity, Vector2.UP)


func _handle_movement(dt: float):
	velocity.x = MaxMovementSpeed * _horizontal_input_direction()
	
	direction = _horizontal_input_direction()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -MaxJumpForce
	
	if direction != 0:
		sprite.scale.x = 1 * -direction
		box_detector.position.x = default_box_detector_position.x * -direction
		button_detector.position.x = default_button_detector_position.x * -direction
		box_placing_position.position.x = default_box_placing_position.x * -direction
		holded_box_position.position.x = default_holded_box_position.x * -direction


func _handle_box_holding_and_button_press_and_buying_fule():
	if Input.is_action_just_pressed("pick"):
		if holded_box == null:
#			holded_box = detected_box if detected_box != null else null
			if detected_box != null:
				holded_box = detected_box
			elif detected_button != null:
				detected_button.press_me()
			elif detected_shop != null:
				detected_shop.get_parent().buy_fule()
		else:
			holded_box.release(box_placing_position.global_position)
			holded_box = null
	
	if holded_box:
		holded_box.pickup(holded_box_position.global_position)


func _apply_gravity(dt: float) -> void:
	velocity.y += Gravity * dt


func _horizontal_input_direction():
	return int(Input.get_action_strength("right") - Input.get_action_strength("left"))


func _on_BoxDetector_body_entered(body: Node) -> void:
	if body.is_in_group("Box"):
		detected_box = body


func _on_BoxDetector_body_exited(body: Node) -> void:
	if detected_box == body:
		detected_box = null


func _on_ButtonDetector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Button"):
		detected_button = area


func _on_ButtonDetector_area_exited(area: Area2D) -> void:
	detected_button = null


func _on_ShopDetector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shop"):
		detected_shop = area


func _on_ShopDetector_area_exited(area: Area2D) -> void:
	detected_shop = null
