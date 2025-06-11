extends Node2D

@onready var timer: Timer = $Timer
@onready var house_mess: Label = $HouseMess
@onready var clean: Label = $Clean
@onready var find: Label = $Find
@onready var hero: Label = $Hero
@onready var white_background: Panel = $white_background

var step: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	house_mess.visible = true
	clean.visible = false
	find.visible = false
	hero.visible = false
	white_background.visible = true
	
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
			find.visible = true
			timer.wait_time = 5
			timer.start()
		2:
			find.visible = false
			hero.visible = true
			timer.wait_time = 4
			timer.start()
		3:
			hero.visible = false
			white_background.visible = false
			timer.stop()  # All done
	step += 1
