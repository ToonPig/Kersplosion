extends HBoxContainer
#dont touch this it works perfectly!
#unless you want to change the sprite file paths, then change the values below
var health_full = preload("res://assets/HealthFull.png")
var health_partial = preload("res://assets/HealthHalfEmpty.png")
var health_empty = preload("res://assets/HealthEmpty.png")

#updates the health bar based on full heart half heart empty heart
func update_health(value):
	for i in get_child_count():
		if value > i  * 2 + 1:
			get_child(i).texture = health_full
		elif value > i * 2:
			get_child(i).texture = health_partial
		else:
			get_child(i).texture = health_empty
