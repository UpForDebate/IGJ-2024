extends Node3D

@export var camera_on : Camera3D
@export var camera_off : Camera3D
@export var one_way = true

func _on_area_3d_body_entered(body):
	camera_on.current = true
	camera_off.current = false


func _on_area_3d_body_exited(body):
	if !one_way:
		camera_off.current = true
		camera_on.current = false
