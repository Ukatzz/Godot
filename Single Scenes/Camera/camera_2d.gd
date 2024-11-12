extends Camera2D

@onready var coins = $"HUD canva/HUD panel/Coins/Label coins"
var gold = 200  # Текущее количество золота

@export var zoomSpeed : float = 10
var zoomTarget : Vector2
var dragStartMousePos = Vector2.ZERO
var dragStartCameraPos = Vector2.ZERO
var isDragging : bool = false

# Границы перемещения камеры
@export var minPosition : Vector2 = Vector2.ZERO
@export var maxPosition : Vector2 = Vector2(500, 500)

func _ready():
	zoomTarget = zoom
	GlobalSignals.connect("enemy_died", Callable(self, "_on_enemy_died"))
	GlobalSignals.connect("gold_spend", Callable(self, "_on_gold_spend"))

func _on_enemy_died(amount: int):
	gold += amount
	coins.text = str(gold)

func _on_gold_spend(amount: int):
	gold -= amount
	coins.text = str(gold)

func _process(delta):
	handle_zoom(delta)
	handle_pan(delta)
	handle_drag()

# Метод для управления зумом камеры
func handle_zoom(delta):
	if Input.is_action_just_pressed("camera_zoom_in") and zoom < Vector2(2, 2):
		zoomTarget *= 1.1
	elif Input.is_action_just_pressed("camera_zoom_out") and zoom > Vector2(0.9, 0.9):
		zoomTarget *= 0.9
	zoom = zoom.slerp(zoomTarget, zoomSpeed * delta)
	clamp_camera_position()  # Применяем ограничение после зума

# Метод для панорамирования камеры с клавишами управления
func handle_pan(delta):
	var moveAmount = Vector2(
		Input.get_action_strength("camera_move_right") - Input.get_action_strength("camera_move_left"),
		Input.get_action_strength("camera_move_down") - Input.get_action_strength("camera_move_up")
	)
	moveAmount = moveAmount.normalized() * delta * 1000 * (1 / zoom.x)
	position += moveAmount
	clamp_camera_position()

# Метод для перетаскивания камеры с помощью мыши
func handle_drag():
	if Input.is_action_just_pressed("camera_pan"):
		dragStartMousePos = get_viewport().get_mouse_position()
		dragStartCameraPos = position
		isDragging = true
	elif Input.is_action_just_released("camera_pan"):
		isDragging = false

	if isDragging:
		var moveVector = get_viewport().get_mouse_position() - dragStartMousePos
		position = dragStartCameraPos - moveVector * (1 / zoom.x) * 0.5  # Коэффициент для лучшего контроля при зуме
		clamp_camera_position()

# Ограничение положения камеры в пределах заданных границ
func clamp_camera_position():
	# Учитываем текущий зум при ограничении границ перемещения
	var adjustedMinPos = minPosition * zoom
	var adjustedMaxPos = maxPosition * zoom
	position.x = clamp(position.x, adjustedMinPos.x, adjustedMaxPos.x)
	position.y = clamp(position.y, adjustedMinPos.y, adjustedMaxPos.y)
