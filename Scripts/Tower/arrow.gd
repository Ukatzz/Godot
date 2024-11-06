extends AnimatedSprite2D

# Переменная для направления стрелы
var direction: Vector2 = Vector2.ZERO
# Скорость движения стрелы
@export var speed: float = 400  # Пиксели в секунду
@export var damage = 10

# Функция для установки направления стрелы
func set_direction(dir: Vector2) -> void:
	direction = dir.normalized()  # Нормализуем вектор направления
	# Вычисляем угол поворота стрелы
	var angle = direction.angle()  # angle() возвращает угол в радианах
	rotation = angle  # Устанавливаем угол поворота стрелы

# Called every frame
func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		# Перемещаем стрелу по направлению с учетом времени
		position += direction * speed * delta
		

func _on_area_2d_body_entered(body: Node2D) -> void:
		# Проверяем, является ли столкнувшийся объект врагом
	if body is CharacterBody2D and body.is_in_group("enemies"):
		# Наносим урон врагу
		if body.has_method("take_damage"):
			body.take_damage(damage)  # Пример, урон 10, можно заменить на вашу логику
		# Уничтожаем стрелу после столкновения
		queue_free()
