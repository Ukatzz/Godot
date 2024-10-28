extends Panel

# Ссылка на позицию, куда будут загружаться башни
@onready var tower_position = $tower_position

func _ready() -> void:
	# Здесь можно инициализировать что-то, если нужно
	pass

func load_tower_scene(tower_scene_path: String) -> void:
	# Загружаем сцену
	var tower_scene = load(tower_scene_path)
	
	if tower_scene:
		# Инстанцируем башню
		var tower_instance = tower_scene.instantiate()
		
		# Устанавливаем позицию инстанса на позицию tower_position
		tower_instance.position = tower_position.position
		
		# Добавляем инстанс башни в сцену
		get_parent().add_child(tower_instance)

func _on_select_red_pressed() -> void:
	load_tower_scene("res://Scenes/Single/Towers/rer_tower.tscn")

func _on_select_blue_pressed() -> void:
	load_tower_scene("res://Scenes/Single/Towers/blue_tower.tscn")

func _on_select_yellow_pressed() -> void:
	load_tower_scene("res://Scenes/Single/Towers/yellow_tower.tscn")
