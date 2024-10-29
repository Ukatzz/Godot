extends Button

@onready var towers = $"../../Towers"

var initial_position: Vector2  # Переменная для хранения начальной позиции

signal tower_selected

func _ready() -> void:
	# Сохраняем начальную позицию при запуске
	initial_position = towers.position
func _on_pressed() -> void:
	
	if towers.visible:
		towers.hide()
	else:
		# Сбрасываем позицию к исходной и показываем панель
		towers.position = initial_position
		towers.show()
	emit_signal("tower_selected")
