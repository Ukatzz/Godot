extends Node2D

@onready var panel: Panel = $Tower_construct/Panel
@onready var tower_place = $Tower_construct

@export var red_tower: PackedScene
@export var blue_tower: PackedScene
@export var yellow_tower: PackedScene

func _ready() -> void:
	panel.visible = false

func _on_select_pressed() -> void:
	panel.visible = !panel.visible

func _on_red_tower_pressed() -> void:
	_spawn_tower(red_tower)

func _on_blue_tower_pressed() -> void:
	_spawn_tower(blue_tower)

func _on_yellow_tower_pressed() -> void:
	_spawn_tower(yellow_tower)

# Функция для создания башни
func _spawn_tower(tower_scene: PackedScene) -> void:
	var tower_instance = tower_scene.instantiate()  # Создаем экземпляр башни
	tower_instance.global_position = tower_place.global_position  # Устанавливаем позицию в `tower_place`
	get_parent().add_child(tower_instance)  # Добавляем экземпляр башни в сцену
	queue_free()