extends Node2D

@onready var fade_rect = $"../ColorRect"# Убедитесь, что это правильный путь

func _ready() -> void:
	fade_rect.modulate.a = 1  # Начальная альфа на 1 (полностью непрозрачный)
	fade_rect.visible = true    # Убедитесь, что ColorRect видим
	fade_in()

func fade_in() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0, 0.5)  # Уменьшаем альфа до 0 за 0.5 секунд
	tween.finished.connect(_on_fade_in_completed)

func _on_fade_in_completed() -> void:
	# Здесь можно добавить логику, которая будет выполнена после завершения плавного появления
	print("Плавный переход завершён.")