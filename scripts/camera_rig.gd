#Script Inspired by Lukky retro camera system
#https://github.com/lukky-nl/retro_camera_system

extends Node3D

@export var target:CharacterBody3D
@onready var camera3D = $Camera3D

@export var stage_dimensions:Vector2

func _process(delta):
	position = lerp(position, target.position, delta * 10.0)
	position.x = clamp(position.x, -stage_dimensions.x/2, stage_dimensions.x/2)
	position.z = clamp(position.z, -stage_dimensions.y/2, stage_dimensions.y/2)
	
	camera3D.look_at(((target.position + position)/2) + Vector3.UP, Vector3.UP)
	
	$DebugBall2.global_position = ((target.position + position)/2) + Vector3.UP
