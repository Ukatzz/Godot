extends AnimatedSprite2D

@export var speed: float = 300.0  # Скорость полета стрелы
var target = null
@export var damage: int = 10  # Урон от стрелы

func _ready() -> void:
	if target:
		look_at(target.global_position)  # Повернуть стрелу в направлении цели

func _process(delta: float) -> void:
	# Проверяем, что цель существует и находится в дереве сцены
	if target and is_instance_valid(target) and target.is_inside_tree():
		# Двигаемся к цели
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta

		# Проверяем, достигли ли цели
		if global_position.distance_to(target.global_position) < 10.0:  # Допуск для попадания
			apply_damage()
			queue_free()  # Удаляем стрелу после попадания
	else:
		queue_free()  # Удаляем стрелу, если цель недоступна

func apply_damage() -> void:
	if target and is_instance_valid(target) and target.has_method("take_damage"):
		target.take_damage(damage)  # Наносим урон цели
