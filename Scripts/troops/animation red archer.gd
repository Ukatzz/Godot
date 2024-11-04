extends AnimatedSprite2D

# Скорость атаки
@export var attack_speed: float = 1.0
@export var attack_timer: float = 0.0

# Сигнал для атаки
signal attack_event(target)

# Указатель на область атаки
@onready var attack_area: Area2D = $"../Area2D"  # Убедитесь, что у вас есть Area2D в сцене

func _ready() -> void:
	play("idle")  # Запускаем анимацию ожидания

func _process(delta: float) -> void:
	attack_timer -= delta
	if attack_timer <= 0:
		var enemy = get_enemy_in_range()
		if enemy:
			attack(enemy)

func get_enemy_in_range() -> Node:
	# Получаем все коллизии с врагами в области атаки
	var enemies = attack_area.get_overlapping_bodies()
	for enemy in enemies:
		if enemy.is_in_group("enemies"):  # Убедитесь, что враги в группе "enemies"
			return enemy
	return null

func attack(target: Node) -> void:
	play("attack")  # Запускаем анимацию атаки
	attack_timer = attack_speed  # Сбрасываем таймер атаки
	emit_signal("attack_event", target)  # Вызываем сигнал атаки
