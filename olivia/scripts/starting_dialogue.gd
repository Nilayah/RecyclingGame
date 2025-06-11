extends Node2D

@onready var timer: Timer = $Timer
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var uh_oh: Label = $UhOh
@onready var bottle_floor: Label = $BottleFloor
@onready var recycling: Label = $Recycling
@onready var welcome: Label = $Welcome
@onready var white_background: Panel = $white_background

var step: int = 0

func _ready():
	welcome.visible = true
	uh_oh.visible = false
	bottle_floor.visible = false
	recycling.visible = false
	
	timer.wait_time = 4
	timer.start

func _on_timer_timeout() -> void:
	match step:
		0:
			welcome.visible = false
			uh_oh.visible = true
			timer.wait_time = 3
			timer.start()
		1:
			uh_oh.visible = false
			bottle_floor.visible = true
			timer.wait_time = 4
			timer.start() 
		2:
			bottle_floor.visible = false
			recycling.visible = true
			white_background.visible = true
			timer.wait_time = 4
			timer.start()
		3:
			recycling.visible = false
			white_background.visible = false
			timer.stop()  # All done
	step += 1
