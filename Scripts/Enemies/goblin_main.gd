extends CharacterBody2D

@onready var anim = $anim  # Убедитесь, что у вас есть AnimatedSprite2D
@onready var path_follow = $".." # Убедитесь, что у вас есть PathFollow2D

@export var health = 100

func _ready() -> void:
	anim.play('walk')

func _process(delta: float) -> void:
	pass

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()  # Удаляет объект из сцены
