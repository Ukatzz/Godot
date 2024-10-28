extends TextureButton

@onready var tower_position = $"../../../Tower_position"
@onready var construct = $"../../../Sprite"
@onready var buttons = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Замените на тело функции при необходимости.

func _on_pressed() -> void:
	if tower_position.get_child_count() > 0:  # Проверяем, есть ли дочерние узлы
		tower_position.get_child(0).queue_free()  # Удаляем только первого ребенка, если это возможно

	construct.visible = true
	buttons.visible = false
