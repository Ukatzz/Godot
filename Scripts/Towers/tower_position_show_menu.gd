extends Node2D  # Или другой подходящий тип узла

@onready var menu_panel = $"../Buttons"  # Ссылка на панель меню
var connected_towers = []  # Массив для отслеживания подключенных башен
var is_menu_visible = false  # Флаг для отслеживания видимости меню

func _ready() -> void:
	menu_panel.visible = true

func _process( float) -> void:
	for child in get_children():
				child.connect("show_menu_signal", Callable(self, "show_menu"))
				connected_towers.append(child)

func show_menu() -> void:
	if is_menu_visible:
		# Если меню уже видно, скрываем его
		menu_panel.hide()
		is_menu_visible = false
	else:
		# Если меню не видно, показываем его
		menu_panel.position = self.position + Vector2(150, -50)
		menu_panel.show()
		is_menu_visible = true  # Меню теперь видно
