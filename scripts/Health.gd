extends Node

@export var health: float = 100

@onready var entity: Node = get_parent()

signal on_die()
signal on_take_damage()

func take_damage(damage: float):
	health = max(0, health - damage)
	on_take_damage.emit()
	
	if health <= 0:
		on_die.emit()
