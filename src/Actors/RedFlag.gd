tool
extends Area2D

export var next_scene: PackedScene

func _on_body_entered(body: PhysicsBody2D) -> void:
	teleport()
	
func _get_configuration_warning() -> String:
	return "The next scene property can't be empty!" if not next_scene else ""

func teleport() -> void:
	get_tree().change_scene_to(next_scene)
