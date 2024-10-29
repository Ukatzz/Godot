extends Control

# Переменная для текстуры начальной башни, задается через инспектор
@export var initial_tower_texture: Texture

# Узел спрайта башни
@onready var tower_sprite = $Sprite
@onready var tower_choose = $Towers
@onready var buttons = $Buttons

# Переменная для отслеживания выбора башни
var is_tower_selected = false

# Инициализация начальной текстуры при запуске
func _ready() -> void:
	tower_choose.hide()
	buttons.hide()
	
	if initial_tower_texture:
		tower_sprite.texture = initial_tower_texture


func _on_tower_select_tower_selected() -> void:
	# Получаем родительский узел
	var parent = get_parent()

	# Перебираем всех детей родительского узла
	for child in parent.get_children():
		# Проверяем, является ли ребенок дочерним узлом башни
		if child.has_node("Towers") and child != self:  # Добавлено условие на текущий узел
			child.get_node("Towers").hide()  # Скрываем панель выбора башни
		if child.has_node("Buttons") and child != self:  # Добавлено условие на текущий узел
			child.get_node("Buttons").hide()  # Скрываем панель выбора башни
