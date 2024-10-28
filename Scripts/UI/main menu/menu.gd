extends Control

@onready var fade_rect = $"../ColorRect"  # Убедитесь, что это правильный путь

@export var new_game_scene: PackedScene
@export var options_scene: PackedScene

func _ready() -> void:
	fade_rect.visible = false  # Убедитесь, что ColorRect изначально невидим

func fade_to_scene(scene: PackedScene) -> void:
	fade_rect.visible = true
	fade_rect.modulate.a = 0  # Начальное значение альфа

	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1, 0.5)

	# После завершения анимации загружаем сцену
	tween.finished.connect(func():
		get_tree().change_scene_to_packed(scene)
	)

func _on_new_game_button_up() -> void:
	fade_to_scene(new_game_scene)

func _on_options_button_up() -> void:
	fade_to_scene(options_scene)

func _on_exit_button_up() -> void:
	get_tree().quit()
