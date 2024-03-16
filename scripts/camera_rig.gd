#Script Inspired by Lukky retro camera system
#https://github.com/lukky-nl/retro_camera_system

extends Node3D

@export var target:CharacterBody3D
@onready var camera3D = $Camera3D

func _process(delta):
	camera3D.look_at(((target.position + position)/2) + Vector3.UP, Vector3.UP)
	$DebugBall2.global_position = ((target.position + position)/2) + Vector3.UP
