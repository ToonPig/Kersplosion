extends StaticBody2D
#old script to test rock interaction to spawn little rocks
var rockChunk = preload("res://scenes/rock_chunk.tscn")
var isEntered = false

#spawns baby rocks
func interact():
	var c = rockChunk.instantiate()
	add_child(c)


func _on_interact_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		isEntered = true

func _on_interact_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		isEntered = false

func _process(delta):
	if isEntered == true:
		if Input.is_action_just_pressed("interact"):
			interact()
