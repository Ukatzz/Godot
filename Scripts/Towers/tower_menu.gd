extends Sprite2D

signal show_menu_signal  # Сигнал для показа меню

func _ready() -> void:
	# Подключаем сигнал к методу "show_menu" родительского узла
	if get_parent().has_method("show_menu"):
		connect("show_menu_signal", Callable(get_parent(), "show_menu"))

func _on_button_pressed() -> void:
	emit_signal("show_menu_signal")  # Излучаем сигнал, когда кнопка нажата
