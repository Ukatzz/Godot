extends Control

# Переменная для текстуры начальной башни, задается через инспектор
@export var initial_tower_texture: Texture

# Узел спрайта башни
@onready var tower_sprite = $Sprite
@onready var tower_choose = $Towers
@onready var buttons = $Buttons

# Переменная для отслеживания выбора башни
var is_tower_selected = false

# Инициализация начальной текстуры при запуске
func _ready() -> void:
	tower_choose.visible=false
	if initial_tower_texture:
		tower_sprite.texture = initial_tower_texture
