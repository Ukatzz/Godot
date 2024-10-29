extends TextureButton

@onready var tower_position = $"../../../Tower_position"
@onready var construct = $"../../../Sprite"
@onready var buttons = $"../.."
@onready var towers = $"../../../Towers"
@onready var icon_default = $icon
@onready var icon_pressed = $icon_pressed

@onready var delete_timer = Timer.new()
@export var delete_delay: float = 1.0  # Задержка перед удалением (в секундах)

var is_mouse_over = false  # Переменная для отслеживания, находится ли мышь над кнопкой

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon_pressed.hide()
	add_child(delete_timer)  # Добавляем таймер как дочерний узел
	delete_timer.connect("timeout", Callable(self, "_on_delete_timeout"))  # Подключаем сигнал

	# Подключаем сигналы для мыши
	self.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	self.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

# Обработчик сигнала при наведении курсора на кнопку
func _on_mouse_entered() -> void:
	is_mouse_over = true

# Обработчик сигнала при уходе курсора с кнопки
func _on_mouse_exited() -> void:
	is_mouse_over = false
	icon_default.show()
	icon_pressed.hide()

func _on_pressed() -> void:
	if is_mouse_over and tower_position.get_child_count() > 0:  # Проверяем, находится ли курсор над кнопкой и есть ли дочерние узлы
		delete_timer.start(delete_delay)  # Запускаем таймер

func _on_delete_timeout() -> void:
	if tower_position.get_child_count() > 0:  # Проверяем, есть ли дочерние узлы
		for i in range(tower_position.get_child_count() - 1, -1, -1):
			tower_position.get_child(i).queue_free()  # Удаляем дочерние узлы

		construct.show()  # Показываем элементы интерфейса
		buttons.hide()
		towers.hide()

	delete_timer.stop()  # Останавливаем таймер после срабатывания

func _on_button_down() -> void:
	icon_default.hide()
	icon_pressed.show()

func _on_button_up() -> void:
	icon_default.show()
	icon_pressed.hide()
