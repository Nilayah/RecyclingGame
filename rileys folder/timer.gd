extends Node2D

@onready var gametimer: Timer = $gametimer
var time_left = 60
@onready var timerlabel: Label = $CanvasLayer/timerlabel


# Citation (Used AI): ChatGPT
func _ready():
	gametimer.start()
	_update_timer_label()

func _on_gametimer_timeout() -> void:
	time_left -= 1
	_update_timer_label()

	if time_left <= 0:
		gametimer.stop()

func _update_timer_label():
	var minutes = int(time_left / 60)
	var seconds = int(time_left % 60)
	var formatted_time = "Time left: %d:%02d" % [minutes, seconds]
	timerlabel.text = formatted_time
