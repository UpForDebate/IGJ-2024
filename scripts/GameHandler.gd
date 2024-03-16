extends Node3D



var state : int = 0
@export var _timelines : Array[DialogicTimeline]
@onready var _timerNode : Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	startGame()
	pass # Replace with function body.



func startGame():
	state = 0
	playTimeline()

func startTimer(fail = 0):
	if (fail != 0):
		pass
	if(state==4):
		endGame()
		return
	_timerNode.start()

func endGame():
	pass
	



func playTimeline():
	var _auxTimeline = Dialogic.start(_timelines[state])
	state += 1
	
	Dialogic.VAR.state = state
	
	Dialogic.timeline_ended.connect(startTimer)
	Dialogic.timeline_ended.connect($Control/Blackscreen/AnimationPlayer.play.bind("fadeIn"))
	



