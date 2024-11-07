extends Node2D

@export var timer_new_wave: Timer
@export var path1: PackedScene
@export var path2: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_new_wave_pressed() -> void:
	timer_new_wave.start()

func _on_spawn_timer_timeout() -> void:
	# Выбор случайного пути
	var random_path = path1 if randf() < 0.5 else path2
	
	# Создание врага из выбранного пути
	var spawn_enemy = random_path.instantiate()
	add_child(spawn_enemy)
