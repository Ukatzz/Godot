extends Node

signal enemy_died(amount)
signal gold_spend(amount)

# Этот метод можно вызывать, когда противник умирает
func emit_enemy_died(amount: int):
	emit_signal("enemy_died", amount)

func emit_gold_spend(amount: int):
	emit_signal("gold_spend",amount)
