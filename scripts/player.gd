extends CharacterBody2D

@export var speed = 400
@export var jump_speed = -600
@export var acceleration = 20
@export var friction = 10

var grenade = preload("res://scenes/grenade.tscn")

#not used atm but eventually for online play indicating little emotions
var emote_textures = {
	"skull": Vector2i(20, 27),
	"heart": Vector2i(20, 25),
	"LOL": Vector2i(22, 25)
}
var coyote_frames = 6
var coyote = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_floor = false
var jumping = false
var dead = false
var health = 10
var power = 20
var isShooting = false

#for when you shoot your gun. spawns in pills
func interact():
	if isShooting == true:
		pass
	else:
		var g = grenade.instantiate()
		owner.add_child(g)
		g.transform = $Muzzle/EntitySpawn.global_transform
		g.launch()
		isShooting = true
		$IsShooting.start()

func _ready():
	#$Emote.hide()
	$CoyoteTimer.wait_time = coyote_frames / 60.0

func get_input(delta):
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = lerp(velocity.x, direction * speed, acceleration * delta)
		#$AnimatedSprite2d.play("walk")
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		#$AnimatedSprite2d.play("idle")
	if jumping:
		if velocity.y < 0:
			pass
			#$AnimatedSprite2d.play("jump_up")
		elif velocity.y > 0:
			pass
			#$AnimatedSprite2d.play("jump_down")
	if Input.is_action_just_pressed("up") and (is_on_floor() or coyote):
		velocity.y = jump_speed
		jumping = true
		
	if Input.is_action_just_pressed("m1"):
		interact()
	
func _physics_process(delta):
	$Muzzle.look_at(get_global_mouse_position())
	velocity.y += gravity * delta
	if dead:
		#$AnimatedSprite2d.play("dead")
		return
	update_health() #checks your health every frame, YIKES
	get_input(delta)
	move_and_slide()
	
	#function for moving objects around such as explosives or crates!
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * power)
	
	#checks if you are jumping and if coyote time is activated
	if is_on_floor() and jumping:
		jumping = false
	if !is_on_floor() and last_floor and !jumping:
		coyote = true
		$CoyoteTimer.start()
	if velocity.x > 0:
		pass
		#$AnimatedSprite2d.flip_h = false
	if velocity.x < 0:
		pass
		#$AnimatedSprite2d.flip_h = true
	last_floor = is_on_floor()


func _on_coyote_timer_timeout():
	coyote = false
	#print("no more jump frames")

#updates the health bar and checks if you are dead or going over the limits
func update_health():
	$HealthBar.update_health(health)
	if health >=10 :
		health = 10
		#print("max health reached")
	elif health <= 0:
		health = 0
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		print("u are dead! no big surpise.")

func _on_is_shooting_timeout() -> void:
	isShooting = false


""" OLD PLAYER CODE UNUSED FOR NOW
@export var speed = 400
var power = 10
var health = 10

func update_health():
	$HealthBar.update_health(health)
	if health >=10 :
		health = 10
		#print("max health reached")
	elif health <= 0:
		health = 0
		get_tree().change_scene_to_file("res://game_over.tscn")
		#print("u are dead!")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if Input.is_action_just_pressed("m1"):
		health = health - 1
	if Input.is_action_just_pressed("m2"):
		health = health + 1
	if Input.is_action_just_pressed("interact"):
		attack()

func _physics_process(delta):
	update_health() #remove later
	get_input()
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * power)


func _on_reach_body_entered(body: Node2D) -> void:
	if body.is_in_group("Mob"):
		print("i attack!")
		body.hurt()

func attack():
	$reach/CollisionShape2D.disabled = false
	#print("take that!")
	await get_tree().create_timer(0.2).timeout #needs a better function later
	#print("i done my thing")
	$reach/CollisionShape2D.disabled = true
	"""
