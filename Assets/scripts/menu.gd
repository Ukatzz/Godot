extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/scenes/tileset_terrains.tscn")


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
