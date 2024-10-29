extends Panel


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		# Проверяем, был ли щелчок за пределами панели
		if not get_global_rect().has_point(event.position):
			self.hide()
