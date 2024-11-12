extends CharacterBody2D

@export var speed = 50
@export var max_health = 25  # Максимальное здоровье
var health = 25  # Текущее здоровье

@onready var bar = $Node/HP
@onready var anim = $Anim
@onready var path = get_parent()

var previous_position = Vector2.ZERO  # Инициализация предыдущей позиции

func _ready() -> void:
	previous_position = path.global_position  # Устанавливаем начальную позицию
	add_to_group("enemies")
	anim.play("walk")
	update_health_bar()  # Установите начальное значение бара

func _process(delta: float) -> void:
	path.progress += speed * delta  # Обновляем положение вдоль пути
	# Обновляем направление движения
	update_direction()

func update_direction() -> void:
	if path.global_position.x > previous_position.x:
		anim.flip_h = false
	elif path.global_position.x < previous_position.x:
		anim.flip_h = true

	# Сохраняем текущую позицию для следующего обновления
	previous_position = path.global_position

func take_damage(amount: int) -> void:
	health -= amount
	if health < 0:
		health = 0  # Убедимся, что здоровье не отрицательное
	update_health_bar()
	if health <= 0:
		die()

func update_health_bar() -> void:
	# Обновляем значение прогресс-бара в процентном соотношении
	if bar:
		bar.value = float(health) / max_health * 100

func die() -> void:
	# Логика смерти, например, анимация или удаление
	GlobalSignals.emit_enemy_died(10)
	queue_free()
