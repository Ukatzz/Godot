extends Button

@onready var towers = $"../../Towers"
# Called when the node enters the scene tree for the first time.

func _on_pressed() -> void:
	towers.visible = true
	
