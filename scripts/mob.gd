extends CharacterBody2D

var speed = 100
var damage = 1
var sight = false
var player = null
var attack = false
var isAttacking = false

func _process(delta):
	#when attacking ittl run this.
	if attack:
		if isAttacking:
			isAttacking = false
			player.health = player.health - damage
			await get_tree().create_timer(0.7).timeout#replace with a timer node someday
			isAttacking = true
	#if player is spotted ittl follow the player
	if sight:
		#print(player.position)
		velocity = Vector2.ZERO
		velocity = position.direction_to(player.position) * speed
		move_and_slide()
#checks if the player is touching it
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		attack = true
		isAttacking = true
#when player leaves makes sure it cannot attack anymore
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		attack = false
		isAttacking = false

""" NO AI FOR NOW
func _on_sight_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("i see you")
		sight = true
		player = body
		move_and_slide()
		

func _on_sight_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("are you still there?")
		sight = false
		player = null

"""
#instantly kill the entity
func hurt():
	print("ouch!")
	queue_free()
