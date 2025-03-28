extends RigidBody2D
#old script for the debug test rock
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
