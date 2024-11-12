extends Node2D

@export var timer_new_wave: Timer
@export var path1: PackedScene
@export var path2: PackedScene

@onready var new_wave_button = $"../Camera2D/HUD canva/New_Wave"

# Массив волн с количеством врагов
@export var waves = [10, 15, 7, 10, 12]  # Массив целых чисел

# Массив характеристик для каждой волны: [скорость, хп]
@export var enemy_stats = [
	{ "speed": 80, "hp": 30 },   # Воля 0
	{ "speed": 100, "hp": 40 },   # Воля 1
	{ "speed": 110, "hp": 45 },   # Воля 2
	{ "speed": 120, "hp": 50 },   # Воля 3
	{ "speed": 130, "hp": 55 }    # Воля 4
]

var current_wave = 0
var enemies_spawned = 0

func _on_new_wave_pressed() -> void:
	new_wave_button.hide()
	timer_new_wave.start()
	if current_wave < waves.size():
		enemies_spawned = 0
	else:
		print("Все волны завершены!")

func _on_spawn_timer_timeout() -> void:
	if current_wave < waves.size():
		# Получаем количество врагов для текущей волны
		var enemy_count = waves[current_wave]
		if enemies_spawned < enemy_count:
			# Выбор случайного пути
			var random_path = path1 if randf() < 0.5 else path2
			# Создание врага из выбранного пути
			var spawn_enemy = random_path.instantiate()
			add_child(spawn_enemy)

			# Получаем характеристики для текущей волны
			var stats = enemy_stats[current_wave]
			var speed = stats["speed"]
			var hp = stats["hp"]

			# Настроим врага
			var path_follow = spawn_enemy.get_child(0)
			var character = path_follow.get_child(0) 

			# Задаем скорость и здоровье врага
			character.speed = speed  # Убедитесь, что у вашего врага есть поле speed
			character.health = hp  # Убедитесь, что у вашего врага есть поле hp
			character.max_health = hp

			enemies_spawned += 1
			print("Текущая волна: ", current_wave, ", создано врагов: ", enemies_spawned)
		else:
			current_wave += 1
			timer_new_wave.stop()
			new_wave_button.show()
