extends Control

@onready var fade_rect = $"../ColorRect" # Убедитесь, что это правильный путь

func _ready() -> void:
	fade_rect.visible = false  # Убедитесь, что ColorRect изначально невидим

func fade_to_scene(scene_path: String) -> void:
	fade_rect.visible = true
	fade_rect.modulate.a = 0  # Начальное значение альфа

	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1, 0.5)

	# Подписка на сигнал завершения tween
	tween.finished.connect(_on_fade_completed.bind(scene_path))

func _on_fade_completed(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)

func _on_new_game_button_up() -> void:
	fade_to_scene("res://Scenes/Levels/level 1/Level1.tscn")

func _on_options_button_up() -> void:
	fade_to_scene("res://Assets/scenes/Levels/map_level_1.tscn")

func _on_exit_button_up() -> void:
	get_tree().quit()
