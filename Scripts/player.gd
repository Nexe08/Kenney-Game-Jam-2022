extends KinematicBody2D


export var MaxMovementSpeed: float = 100
export var Gravity: float = 800

var detected_box: Node = null
var holded_box: Node = null

onready var velocity: Vector2 = Vector2.ZERO
onready var direction: int = -1 # facing direction of character

onready var default_box_detector_position = $BoxDetector.position
onready var default_box_placing_position = $BoxPlacingPosition.position

onready var box_detector = $BoxDetector
onready var box_placing_position = $BoxPlacingPosition
onready var holded_box_position = $HoldedBoxPosition
onready var sprite = $Sprite


func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_apply_gravity(delta)
	_handle_box_holding()
	velocity = move_and_slide(velocity, Vector2.UP)


func _handle_movement(dt: float):
	velocity.x = MaxMovementSpeed * _horizontal_input_direction()
	
	direction = _horizontal_input_direction()
	
	if direction != 0:
		sprite.scale.x = 1 * -direction
		box_detector.position.x = default_box_detector_position.x * -direction
		box_placing_position.position.x = default_box_placing_position.x * -direction


func _handle_box_holding():
	if Input.is_action_just_pressed("pick"):
		if holded_box == null:
			holded_box = detected_box if detected_box != null else null
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
