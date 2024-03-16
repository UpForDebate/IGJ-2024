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
	Dialogic.signal_event.connect(endGame)
	playTimeline()

func startTimer(fail = 0):
	if (fail != 0):
		pass
	if(state==4):
		endGame()
		return
	_timerNode.start()

func endGame():
	Dialogic.timeline_ended.disconnect(startTimer)

	Dialogic.timeline_ended.connect(Dialogic.start.bind(_timelines[3]))
	pass
	



func playTimeline():
	if(state==3):
		endGame()
		return
	var _auxTimeline = Dialogic.start(_timelines[state])
	state += 1
	_timerNode.stop()
	Dialogic.VAR.state = state
	
	Dialogic.timeline_ended.connect(startTimer)
	Dialogic.timeline_ended.connect($Control/Blackscreen/AnimationPlayer.play.bind("fadeIn"))
	Dialogic.timeline_ended.connect(_timerNode.start)
	
	if(state==2):
		_timerNode.wait_time = 180
	





func _on_timer_timeout():
	endGame()
	Dialogic.VAR.isTimerOver = true
