extends KinematicBody2D
class_name Enemy

const floor_normal: = Vector2.UP

export var speed: = Vector2(50.0, 350.0)
export var gravity: = 3000.0

var player_reference

var _velocity: = Vector2.ZERO

func _ready() -> void:
	set_physics_process(true)
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.x *= -1 if is_on_wall() else 1
	_velocity.y = move_and_slide(_velocity, floor_normal).y

func kill() -> void:
	queue_free()
