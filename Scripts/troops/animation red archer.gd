extends AnimatedSprite2D

@export var attack_speed: float = 1.0
@export var attack_cooldown = 1.0
var time_since_last_attack = 0.0
var target = null

@export var arrow_scene: PackedScene  # Задайте сцену стрелы (Arrow.tscn)
@onready var attack_area: Area2D = $"../Area2D"

func _ready() -> void:
	play("idle")
	connect("frame_changed", Callable(self, "_on_frame_changed"))  # Подключаем сигнал frame_changed
	if attack_area:
		attack_area.connect("body_entered", Callable(self, "_on_body_entered"))
		attack_area.connect("body_exited", Callable(self, "_on_body_exited"))
		attack_area.monitoring = is_visible_in_tree()

func _on_body_entered(body):
	if is_visible_in_tree() and body.name == "Goblin":
		target = body

func _on_body_exited(body):
	if body == target:
		target = null
		play("idle")

func _process(delta):
	if target:
		time_since_last_attack += delta
		if time_since_last_attack >= attack_cooldown:
			update_facing_direction(target)  # Поворачиваемся к цели перед атакой
			play("attack")  # Запускаем анимацию атаки после поворота
			time_since_last_attack = 0.0
	else:
		play("idle")

func _on_frame_changed():
	if animation == "attack" and frame == 6:  # Проверяем, что это 6-й кадр атаки
		shoot_arrow()

func shoot_arrow():
	if arrow_scene and target:
		var arrow_instance = arrow_scene.instantiate()
		arrow_instance.global_position = global_position  # Начало у башни
		arrow_instance.target = target  # Устанавливаем цель для стрелы
		arrow_instance.damage = 10  # Устанавливаем урон стрелы, если нужно
		get_tree().root.add_child(arrow_instance)  # Добавляем стрелу в корень сцены для независимого движения

func update_facing_direction(target):
	# Проверяем, находится ли цель слева или справа, и поворачиваемся
	flip_h = target.global_position.x < global_position.x
