extends CharacterBody3D


const SPEED = 2.5
const SPRINT_SPEED = 5.0
const ROTATION_SPEED = 1.66

@onready var _animator = $Character/AnimationPlayer
@onready var _interaction_area = $InteractionArea
var interactableNode : Node3D
@export var _timer : Timer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")



func _ready():
	Dialogic.signal_event.connect(deleteInteractable)

func _physics_process(delta):
	var current_speed = SPEED
	var walk_anim = "Walk"
	if(Dialogic.current_timeline!=null):
		_animator.play("Idle", 1.0, 1.0, false)
		return

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
		_animator.play_backwards("Walk", -1)
		velocity = (-1) * forward * SPEED
	else:
		_animator.play("Idle", 1.0, 1.0, false)
		velocity.z = move_toward(velocity.z, 0, current_speed)
		velocity.x = move_toward(velocity.x, 0, current_speed)
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()


func _process(_delta):
	if (Dialogic.current_timeline !=null):
		return
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
		if closest != null && closest.get_meta("interactTimeline")!=null:
			Dialogic.start(closest.get_meta("interactTimeline"))
			interactableNode = closest

		if closest != null && closest.get_meta("door") == true:
			if($"../".state ==2 && _timer.time_left>90):
				return
			$"../".playTimeline()


func deleteInteractable(argument):
	if argument == "deleteInteractable":
		interactableNode.queue_free()



func _on_take_damage():
	print_debug("Great Heavens! It appears I have been hit!")
