extends CharacterBody2D

@onready var anim = $anim  # Убедитесь, что у вас есть AnimatedSprite2D
@onready var path_follow = $".." # Убедитесь, что у вас есть PathFollow2D

@export var speed = 200  # Скорость движения

func _ready() -> void:
	anim.play('walk')

func _process(delta: float) -> void:
	pass
