extends Control

#quits game, duh!
func _on_quit_pressed() -> void:
	get_tree().quit()

#launches the test level
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test_level.tscn")

#loads about page
func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/about_menu.tscn")

#for the about menu
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

#for the game over menu bringing you back to the main menu
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

#opens link to my website (located on the about page)
func _on_website_pressed() -> void:
	OS.shell_open("https://pumpkinsite.neocities.org/") 
