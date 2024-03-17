extends Control

@onready var level = preload("res://Assets/Architecture Pack/___ DemoScene/SampleScene.scn")

func _on_play_button_pressed():
	var node = level.instantiate()
	get_parent().add_child(node)
	self.queue_free()


func _on_quit_button_pressed():
	get_tree().quit()
