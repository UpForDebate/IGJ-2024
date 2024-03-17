extends Label

@onready var _timerNode :Timer = $"../../Timer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "0" + str(int(_timerNode.time_left/60)) + ":" + (("0" + str(int(_timerNode.time_left)%60)) if (int(_timerNode.time_left)%60<10) else str(int(_timerNode.time_left)%60))
