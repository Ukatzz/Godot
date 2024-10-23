extends CharacterBody2D

@export var SPEED = 300.0

# Хранит последнюю нажатую клавишу для каждой оси
var last_horizontal_input := 0
var last_vertical_input := 0

func _input(event: InputEvent) -> void:
	# Обработка нажатий горизонтальных клавиш
	if event.is_action_pressed("Move_Left"):
		last_horizontal_input = -1
	elif event.is_action_pressed("Move_Right"):
		last_horizontal_input = 1
	elif event.is_action_released("Move_Left") and Input.is_action_pressed("Move_Right"):
		last_horizontal_input = 1
	elif event.is_action_released("Move_Right") and Input.is_action_pressed("Move_Left"):
		last_horizontal_input = -1
	elif event.is_action_released("Move_Left") or event.is_action_released("Move_Right"):
		last_horizontal_input = 0
	
	# Обработка нажатий вертикальных клавиш
	if event.is_action_pressed("Move_Up"):
		last_vertical_input = -1
	elif event.is_action_pressed("Move_Down"):
		last_vertical_input = 1
	elif event.is_action_released("Move_Up") and Input.is_action_pressed("Move_Down"):
		last_vertical_input = 1
	elif event.is_action_released("Move_Down") and Input.is_action_pressed("Move_Up"):
		last_vertical_input = -1
	elif event.is_action_released("Move_Up") or event.is_action_released("Move_Down"):
		last_vertical_input = 0

func _physics_process(delta: float) -> void:
	# Создаем вектор направления движения
	var direction := Vector2.ZERO
	
	# Используем последнее нажатое направление для движения
	direction.x = last_horizontal_input
	direction.y = last_vertical_input
	
	# Нормализуем вектор движения, чтобы скорость по диагонали была равна скорости по одной оси
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	# Задаем скорость движения
	velocity = direction * SPEED
	
	# Двигаем персонажа
	move_and_slide()
