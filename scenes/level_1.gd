extends Node2D

@onready var player: Player = $Player

@onready var end_timer: Timer = $EndTimer

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if player.current_health == 0:
		end_timer.start()

func _on_end_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://screens/bad_ending_scene.gd")
