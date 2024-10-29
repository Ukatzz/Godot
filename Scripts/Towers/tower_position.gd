extends Panel

@onready var tower_position = $"../Tower_position"
@onready var construct = $"../Sprite"
@onready var buttons = $"../Buttons"

func _ready() -> void:
	# Включаем обработку событий
	set_process_unhandled_input(true)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		# Проверяем, был ли щелчок за пределами панели
		if not get_global_rect().has_point(event.position):
			self.hide()

func load_tower_scene(tower_scene_path: String) -> void:
	var tower_scene = load(tower_scene_path)
	
	if tower_scene:
		var tower_instance = tower_scene.instantiate()
		tower_instance.position = tower_position.position
		tower_position.add_child(tower_instance)
	else:
		print("Ошибка: не удалось загрузить сцену башни по пути: ", tower_scene_path)

func _on_select_red_pressed() -> void:
	delete_previos()
	load_tower_scene("res://Scenes/Single/Towers/red_tower.tscn")
	hide_ui()

func _on_select_blue_pressed() -> void:
	delete_previos()
	load_tower_scene("res://Scenes/Single/Towers/blue_tower.tscn")
	hide_ui()

func _on_select_yellow_pressed() -> void:
	delete_previos()
	load_tower_scene("res://Scenes/Single/Towers/yellow_tower.tscn")
	hide_ui()

func hide_ui():
	self.hide()
	construct.hide()
	buttons.hide()

func delete_previos():
	if tower_position.get_child_count() > 0:  # Проверяем, есть ли дочерние узлы
		for i in range(tower_position.get_child_count() - 1, -1, -1):
			tower_position.get_child(i).queue_free()  # Удаляем дочерние узлы
