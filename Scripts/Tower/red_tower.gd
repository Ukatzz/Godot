extends Node2D

@onready var anim: AnimatedSprite2D = $Archer
@onready var attack_area: Area2D = $Attack_Area

@export var build_scene_path : String = "res://Single Scenes/Towers/tower_build.tscn"
@export var arrow_scene_path : String = "res://Single Scenes/Characters/Archers/arrow.tscn" 

@export var first_shot_timer: Timer 
@export var shot_delay_timer: Timer

var enemies_in_range = []
var has_enemy_in_area = false
var is_attacking = false

var attack_frame = 0

func _ready() -> void:
	anim.play("idle")
	
	first_shot_timer.start()
	shot_delay_timer.start()
	# Подключаем сигналы области атаки
	attack_area.connect("body_entered", Callable(self, "_on_enemy_entered"))
	attack_area.connect("body_exited", Callable(self, "_on_enemy_exited"))
	
	# Подключаем сигнал анимации для отслеживания фреймов
	anim.connect("frame_changed", Callable(self, "_on_frame_changed"))

	# Проверка врагов в области при загрузке сцены
	_check_enemies_in_area()

func _check_enemies_in_area() -> void:
	var overlapping_bodies = attack_area.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("enemies"):
			enemies_in_range.append(body)
			has_enemy_in_area = true
			is_attacking = true
			anim.play("attack")

func _on_enemy_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		enemies_in_range.append(body)
		has_enemy_in_area = true
		first_shot_timer.start()

func _on_enemy_exited(body: Node) -> void:
	if body.is_in_group("enemies"):
		enemies_in_range.erase(body)
		if enemies_in_range.size() == 0:
			has_enemy_in_area = false
			is_attacking = false
			anim.play("idle")

func _on_frame_changed() -> void:
	# Отслеживаем фрейм анимации и создаем стрелу, если нужно
	if anim.frame == 6 and has_enemy_in_area and is_attacking:
		_create_arrow()
		shot_delay_timer.start()  # Запускаем таймер задержки между выстрелами

	# Если анимация завершена, сбрасываем флаг атаки
	if anim.animation == "attack" and anim.frame == 7 :  # Последний фрейм анимации
		is_attacking = false
		anim.play("idle")  # Возвращаемся в состояние покоя

func _create_arrow() -> void:
	var arrow_scene = load(arrow_scene_path)
	var arrow_instance = arrow_scene.instantiate()
	arrow_instance.position = self.position + Vector2(0, -55)

	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		arrow_instance.set_target(target_enemy)  # Передаем врага как цель стрелы
		get_parent().add_child(arrow_instance)


func _on_first_shot_timeout() -> void:
	if has_enemy_in_area:
		is_attacking = true
		anim.play("attack")

func _on_delay_shots_timeout() -> void:
	if has_enemy_in_area:
		is_attacking = true
		anim.play("attack")

func _process(_delta: float) -> void:
	if is_attacking:
		if anim.animation != "attack":
			anim.play("attack")
	else:
		if anim.animation != "idle":
			anim.play("idle")
	
	if has_enemy_in_area and enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		if target_enemy.global_position.x < self.global_position.x:
			anim.scale.x = -1
		else:
			anim.scale.x = 1


func _on_upgrade_pressed() -> void:
	pass # Замените на реализацию улучшения.

func _on_replace_pressed() -> void:
	pass # Замените на реализацию замены.

func _on_delete_pressed() -> void:
	var build_scene = load(build_scene_path)
	var build_instance = build_scene.instantiate()  # Создаем экземпляр башни
	build_instance.position = self.position  # Устанавливаем позицию в `tower_place`
	get_parent().add_child(build_instance)  # Добавляем экземпляр башни в сцену
	queue_free()  # Удаляем текущую башню
