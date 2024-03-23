extends Control

@onready var level = preload("res://level.tscn")

func _ready():
	Dialogic.VAR.reset()
	pass

func _on_play_button_pressed():
	var node = level.instantiate()
	get_parent().add_child(node)
	get_parent().remove_child(self)


func _on_quit_button_pressed():
	get_tree().quit()
