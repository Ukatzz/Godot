extends Node2D

@onready var path_follow : PathFollow2D = $Path1/PathFollow

@export var speed = 100 # Скорость движения

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += speed * delta
	# Устанавливаем угол поворота спрайта в 0
