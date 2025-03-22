extends RigidBody2D

var thrust = Vector2()
var kaboom = false
#gets called whenever the pill spawns making sure it flies away
func launch():
	$Timer.start()
	thrust = transform.x * 500
	apply_central_impulse(thrust)
#checks if what it touches is a player or bot, in which case ittl call different functions
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		explosion()
		var player = body
		player.health = player.health - 1
		queue_free()
	if body.is_in_group("Mob"):
		explosion()
		body.hurt()
		queue_free()
#after the timer node ends ittl kill the pill
func _on_timer_timeout() -> void:
	explosion()
	queue_free()

#big kaboom on grenade position
func explosion():
	for node: Node in get_parent().get_children():
		if node is RigidBody2D:
			var pos : Vector2 = $Area2D.get_global_position()
			#print(pos)
			var direction: Vector2 = node.global_position - pos
			var distance: float = direction.length()
			var impulse_power: float = 600.0
			var range: float = 100.0
			if distance < range:
				node.apply_impulse(direction.normalized() * impulse_power)
