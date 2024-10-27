extends CharacterBody2D

@export var speed = 1000

func _ready():
	anim()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = 0
	var path_follow = get_parent() # Персонаж находится под PathFollow2D
	path_follow.progress += speed * delta # Увеличиваем прогресс

	if speed > 0:
		$Goblin.flip_h = true  # Если персонаж движется влево
	else:
		$Goblin.flip_h = false # Если персонаж движется вправо
	# Проверяем, если прогресс достиг конца пути (максимум 1)
	if path_follow.progress_ratio >= 1:
		queue_free() # Удаляем персонажа после завершения пути
		
func anim():
	var sprite = $Goblin # Проверяем наличие AnimatedSprite2D
	if sprite:
		sprite.play("walk") # Запускаем анимацию "ходьбы"
