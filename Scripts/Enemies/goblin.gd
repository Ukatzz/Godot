extends Node2D

@export var speed = 100 # Скорость движения
@export var spawn_interval = 2.0 # Интервал появления врагов
@export var enemy_scene : PackedScene # Путь к сцене врага, чтобы можно было инстанцировать новых врагов

@onready var path_follow : PathFollow2D = $Path1/PathFollow
@onready var start_wave_button : Button = $StartWaveButton
@onready var spawn_timer : Timer = $SpawnTimer

# Функция для начала новой волны
func _on_start_wave_button_pressed():
	spawn_timer.start(spawn_interval)

# Функция для появления нового врага
func _on_spawn_timer_timeout():
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = path_follow.global_position
	new_enemy.speed = speed

# Called every frame
func _process(delta: float) -> void:
	path_follow.progress += speed * delta

func _ready():
	# Подключаем сигнал для кнопки
	start_wave_button.connect("pressed", Callable (self, "_on_start_wave_button_pressed"))
	# Подключаем сигнал для таймера
	spawn_timer.connect("timeout", Callable (self, "_on_spawn_timer_timeout"))
