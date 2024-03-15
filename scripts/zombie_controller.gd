extends CharacterBody3D

const SPEED = 1.3
const ROTATION_SPEED = 1.66
const ATTACK = 15
const ATTACK_OSCILATION = 0.4

@onready var _animator = $Character/AnimationPlayer
@export var state : String = ""

var _playerpos: Node3D

func _ready():
	_animator.play("survivalHorror/Zombie Idle")

func _physics_process(delta):
	if (state == "chase"):
		look_at(Vector3(_playerpos.position.x, position.y, _playerpos.position.z))
		
		_animator.play("survivalHorror/Zombie Walk", 1.0, 1.0, false)
		velocity = -transform.basis.z * SPEED
		move_and_slide()




func _on_observation_area_body_entered(body):
	if (body.name == "Player"):
		_playerpos = body
		state = "chase"


func _on_attack_area_body_entered(body):
	if (body.name == "Player"):
		state = "attack"
		look_at(Vector3(_playerpos.position.x, position.y, _playerpos.position.z))
		_animator.play("survivalHorror/Zombie Attack", 0.1, 1.5, false)


func _on_attack_body_entered(body):
	if (body.has_node("Health")):
		body.get_node("Health").take_damage(ATTACK - (ATTACK * (randf_range(0, ATTACK_OSCILATION) * (randi_range(-1, 1)))))

func _on_die():
	print_debug(name + " is dead.")
	_animator.play("survivalHorror/Zombie Dying")
	set_physics_process(false)


func _on_take_damage():
	print_debug(name + " is hurt, " + name + " is sad...")
