extends Panel

# Ссылка на позицию, куда будут загружаться башни
@onready var tower_position = $"../Tower_position"
@onready var construct = $"../Sprite"

func _ready() -> void:
	# Инициализация, если нужно
	pass

func load_tower_scene(tower_scene_path: String) -> void:
	var tower_scene = load(tower_scene_path)
	
	if tower_scene:
		var tower_instance = tower_scene.instantiate()
		tower_instance.position = tower_position.position
		tower_position.add_child(tower_instance)  # Изменено здесь
	else:
		print("Ошибка: не удалось загрузить сцену башни по пути: ", tower_scene_path)

func _on_select_red_pressed() -> void:
	load_tower_scene("res://Scenes/Single/Towers/red_tower.tscn")
	hide_ui()

func _on_select_blue_pressed() -> void:
	load_tower_scene("res://Scenes/Single/Towers/blue_tower.tscn")
	hide_ui()

func _on_select_yellow_pressed() -> void:
	load_tower_scene("res://Scenes/Single/Towers/yellow_tower.tscn")
	hide_ui()

func hide_ui():
	print("Скрываю UI")
	self.visible = false
	construct.visible = false
