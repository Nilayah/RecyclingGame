extends Node2D

@onready var timer: Timer = $Timer
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var uh_oh: Label = $UhOh
@onready var bottle_floor: Label = $BottleFloor
@onready var recycling: Label = $Recycling

var step: int = 0

func _ready():
	uh_oh.visible = true
	bottle_floor.visible = false
	recycling.visible = false
	
	timer.wait_time = 3
	timer.start

func _on_timer_timeout() -> void:
	match step:
		0:
			uh_oh.visible = false
			bottle_floor.visible = true
			timer.wait_time = 6
			timer.start()
		1:
			bottle_floor.visible = false
			recycling.visible = true
			timer.wait_time = 7
			timer.start() 
		2:
			recycling.visible = false
			timer.stop()  # All done
	step += 1
