extends Area2D

@onready var timer: Timer = $Timer
@onready var gr_trash: Label = $GrTrash
@onready var come_back: Label = $ComeBack

var step: int = 0
const Player = preload("res://player/player.gd")
var player: Player = null
var triggered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gr_trash.visible = false
	come_back.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body as Player
	
	if triggered == true:
		return
	
	triggered = true
	gr_trash.visible = true
	
	timer.wait_time = 3
	timer.start()

func _on_timer_timeout() -> void:
	match step:
		0:
			gr_trash.visible = false
			come_back.visible = true
			timer.wait_time = 7
			timer.start()
		1:
			come_back.visible = false
			timer.stop()  # All done
	step += 1
