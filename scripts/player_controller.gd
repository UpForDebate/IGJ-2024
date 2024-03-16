extends CharacterBody3D


const SPEED = 2.5
const SPRINT_SPEED = 5.0
const ROTATION_SPEED = 1.66

@onready var _animator = $Character/AnimationPlayer
@onready var _interaction_area = $InteractionArea

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	var current_speed = SPRINT_SPEED if Input.is_action_pressed("sprint") else SPEED
	var walk_anim = "survivalHorror/Jog Forward" if Input.is_action_pressed("sprint") else  "survivalHorror/Walking"
	if(Dialogic.current_timeline!=null):
		_animator.play("survivalHorror/Idle", 1.0, 1.0, false)
		return
	if Input.is_action_pressed("aim"):
		_animator.play("survivalHorror/Knife Aim")

	# Handle Character rotation
	if Input.is_action_pressed("turn_right"):
		rotation.y -= ROTATION_SPEED * delta
		velocity = Vector3.ZERO
	else: if Input.is_action_pressed("turn_left"):
		rotation.y += ROTATION_SPEED * delta
		velocity = Vector3.ZERO

	var forward = transform.basis.z
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("walk_forward"):
		_animator.play(walk_anim, 1.0, 1.0, false)
		velocity = forward * current_speed
	else: if Input.is_action_pressed("walk_backwards"):
		_animator.play_backwards("survivalHorror/Walking", -1)
		velocity = (-1) * forward * SPEED
	else:
		_animator.play("survivalHorror/Idle", 1.0, 1.0, false)
		velocity.z = move_toward(velocity.z, 0, current_speed)
		velocity.x = move_toward(velocity.x, 0, current_speed)
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()


func _process(_delta):
	if(Input.is_action_just_pressed("interact")):
		var interactablesInRange = _interaction_area.get_overlapping_bodies()
		var closest : Node3D
		var closestDistance : float = INF
		for interactable : Node3D in interactablesInRange:
			if(closest==null):
				closest = interactable
				closestDistance = (closest.position-position).length()
			if((interactable.position-position).length()<closestDistance &&closest.get_meta("interactTimeline")!=null):
				closest = interactable
				closestDistance = (closest.position-position).length()
		if closest != null && closest.get_meta("interactionTiemeline")!=null:
			Dialogic.start(closest.get_meta("interactTimeline"))


func _on_die():
	print_debug("I have died. Anyways...")
	_animator.play("survivalHorror/Dying")
	set_physics_process(false)


func _on_take_damage():
	print_debug("Great Heavens! It appears I have been hit!")
