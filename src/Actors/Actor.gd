extends KinematicBody2D
class_name Actor

const floor_normal: = Vector2.UP
export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
var velocity: = Vector2.ZERO

#func _physics_process(delta: float) -> void:
	#velocity.y += gravity * delta
	#velocity = move_and_slide(velocity)
