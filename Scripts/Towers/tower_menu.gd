extends Sprite2D

signal show_menu_signal  # Сигнал для показа меню

func _on_button_pressed() -> void:
	emit_signal("show_menu_signal")  # Излучаем сигнал, когда кнопка нажата
