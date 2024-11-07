extends Camera2D

@onready var coins = $"HUD canva/HUD panel/Coins/Label coins"
var gold = 200  # Хранит текущее количество золота

func _ready():
	# Подключаемся к глобальному сигналу
	GlobalSignals.connect("enemy_died", Callable(self, "_on_enemy_died"))
	GlobalSignals.connect("gold_spend", Callable(self, "_on_gold_spend"))

func _on_enemy_died(amount: int):
	gold += amount  # Увеличиваем количество золота
	coins.text = str(gold)  # Обновляем текст лейбла

func _on_gold_spend(amount: int):
	gold -= amount
	coins.text = str(gold)
