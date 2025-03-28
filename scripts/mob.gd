extends CharacterBody2D

var grenade = preload("res://scenes/ai_grenade.tscn")

var speed = 1 #minus moves backwards positives move forwards
var damage = 1
var sight = false
var player = null
var attack = false
var isAttacking = false
var acceleration = 20
var power = 20
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumping = false
var jump_speed = -600
var isShooting = true

func _process(delta):
	#when attacking ittl run this.
	if attack:
		if isAttacking:
			isAttacking = false
			player.health = player.health - damage
			await get_tree().create_timer(0.7).timeout#replace with a timer node someday
			isAttacking = true

	#pve mode walking
	var jumpcalc = randi_range(-50, 50) #temp random jump intervals
	if jumpcalc == 5 and is_on_floor():
		jumping = true
	velocity.y += gravity * delta
	if jumping:
		velocity.y = jump_speed
		jumping = false

	#if player is spotted ittl follow the player
	if sight:
		#print(player.position)
		var dir = player.global_position.x - global_position.x
		velocity.x = dir * speed
		move_and_slide()


	#pve shooting
	if sight:
		$Muzzle.look_at(player.global_position)
		if isShooting:
			var g = grenade.instantiate()
			owner.add_child(g)
			g.transform = $Muzzle/EntitySpawn.global_transform
			g.launch()
			$IsShooting.start()
			isShooting = false

	#function for moving objects around such as explosives or crates!
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * power)

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

#checks if player spotted
func _on_sight_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("i see you")
		sight = true
		player = body
		#move_and_slide()
		
#makes sure player isnt forever seen
func _on_sight_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("are you still there?")
		sight = false
		player = null


#instantly kill the entity
func hurt():
	print("ouch!")
	queue_free()


func _on_is_shooting_timeout() -> void:
	isShooting = true
