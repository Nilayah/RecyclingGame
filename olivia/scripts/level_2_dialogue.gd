extends Node2D

@onready var timer: Timer = $Timer
@onready var house_mess: Label = $HouseMess
@onready var clean: Label = $Clean
@onready var hero: Label = $Hero

var step: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	house_mess.visible = true
	clean.visible = false
	hero.visible = false
	
	timer.wait_time = 4
	timer.start()

func _on_timer_timeout() -> void:
	match step:
		0:
			house_mess.visible = false
			clean.visible = true
			timer.wait_time = 4
			timer.start()
		1:
			clean.visible = false
			hero.visible = true
			timer.wait_time = 4
			timer.start()
		2:
			hero.visible = false
			timer.stop()  # All done
	step += 1
