extends TextureButton

@onready var towers = $"../../../Towers"
@export var offset: Vector2  # Смещение для подъема панели
var original_position: Vector2  # Переменная для хранения начальной позиции
@onready var icon_default = $icon
@onready var icon_pressed = $icon_pressed

var is_mouse_over = false  # Переменная для отслеживания, находится ли мышь над кнопкой

func _ready() -> void:
	# Сохраняем начальную позицию при запуске
	original_position = towers.position
	icon_pressed.hide()

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
	# Сбрасываем позицию к начальной и добавляем смещение
	towers.position = original_position + offset
	towers.show()

func _on_button_down() -> void:
	icon_default.hide()
	icon_pressed.show()
	
func _on_button_up() -> void:
	icon_default.show()
	icon_pressed.hide()
