extends Node2D  # Или другой подходящий тип узла

@onready var menu_panel = $"../Buttons"  # Ссылка на панель меню

func show_menu() -> void:
	
	var parent = get_parent().get_parent()

	# Перебираем всех детей родительского узла
	for child in parent.get_children():
		# Проверяем, является ли ребенок дочерним узлом башни
		if child.has_node("Towers") and child != self:  # Добавлено условие на текущий узел
			child.get_node("Towers").hide()  # Скрываем панель выбора башни
		if child.has_node("Buttons") and child != self:  # Добавлено условие на текущий узел
			child.get_node("Buttons").hide()  # Скрываем панель выбора башни
	# Проверяем текущее состояние видимости и переключаем
	if menu_panel.visible:
		menu_panel.hide()
	else:
		menu_panel.show()
	
