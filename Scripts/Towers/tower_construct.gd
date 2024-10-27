extends Button

# Ссылка на панель
@onready var panel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.visible = false  # Скрыть панель при старте
	self.pressed.connect(_on_pressed)  # Подключаем сигнал нажатия к функции

# Функция, срабатывающая при нажатии на кнопку
func _on_pressed() -> void:
	panel.visible = not panel.visible  # Переключаем видимость панели
