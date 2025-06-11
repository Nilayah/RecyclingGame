extends Node2D

@onready var player: Player = $Player
@onready var end_timer: Timer = $EndTimer
@onready var trash_bin: Area2D = $Bins/TrashBin
@onready var recycling_bin: Area2D = $Bins/RecyclingBin
@onready var trash_bin2: Area2D = $Bins/TrashBin2
@onready var recycling_bin2: Area2D = $Bins/RecyclingBin2

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if player.current_health == 0:
		player.current_health -= 1
		end_timer.start()
	if trash_bin.items_in_bin_count + recycling_bin.items_in_bin_count + trash_bin2.items_in_bin_count + recycling_bin2.items_in_bin_count == 13:
		trash_bin.items_in_bin_count += 1
		end_timer.start()

func _on_end_timer_timeout() -> void:
	if player.incorrect_bins == 0:
		get_tree().change_scene_to_file("res://scenes/good_ending_scene.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/bad_ending_scene.tscn")
