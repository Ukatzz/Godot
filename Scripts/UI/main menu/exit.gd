extends TextureButton

@onready var label = $Label_exit_button  # Получаем ссылку на Label внутри кнопки

# Called when the button is pressed.
func _on_pressed() -> void:
	_on_button_down()

# Called when the button is released.
func _on_button_up() -> void:
	# Возвращаем цвет обратно
	self.modulate = Color(1, 1, 1)
	# Поднимаем кнопку обратно
	var tween = create_tween()
	tween.tween_property(self, "position:y", self.position.y - 5, 0.1)
	  # Измените на position

# Called when the button is pressed down.
func _on_button_down() -> void:
	# Затемняем кнопку
	self.modulate = Color(0.5, 0.5, 0.5)  # Задаем цвет для затемнения
	# Опускаем кнопку
	var tween = create_tween()
	tween.tween_property(self, "position:y", self.position.y + 5, 0.1) # Измените на position
