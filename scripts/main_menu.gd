extends Control

func _ready() -> void:
	if has_node("AboutAndCredits"):
		$AboutAndCredits.visible_ratio = 0.0

func _process(delta: float) -> void:
	if has_node("AboutAndCredits"):
		$AboutAndCredits.visible_ratio += 0.0 if $AboutAndCredits.visible_ratio >= 1.0 else delta * 2.0

#quits game, duh!
func _on_quit_pressed() -> void:
	get_tree().quit()

#launches the test level
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/test_level.tscn")

#loads about page
func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/about_menu.tscn")

#for the about menu
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

#for the game over menu bringing you back to the main menu
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

#opens link to my website (located on the about page)
func _on_website_pressed() -> void:
	OS.shell_open("https://pumpkinsite.neocities.org/") 

# Multiplayer host a game
func _on_host_pressed() -> void:
	pass

# Multiplayer join a game
func _on_join_pressed() -> void:
	pass

#goes to multiplayer menu
func _on_multiplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/multiplayer.tscn")
