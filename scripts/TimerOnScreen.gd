extends Label

@onready var _timerNode :Timer = $"../../Timer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = str(int(_timerNode.time_left/60)) + ":" + str(int(_timerNode.time_left)%60)
