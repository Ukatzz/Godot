extends CharacterBody2D

@export var speed = 50
@export var health = 25

@onready var anim = $Anim
@onready var path = get_parent()


func _ready() -> void:
	add_to_group("enemies")
	anim.play("walk")

func _process(delta: float) -> void:
	path.progress += speed*delta
	
func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()

# Метод для смерти врага
func die() -> void:
	# Логика смерти, например, анимация или удаление
	queue_free()
