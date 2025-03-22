#script redudant. needs to be deleted later

extends Control
#this function is already working in the main menu script
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
