extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer


func _ready():
	canvas_layer.visible = true

func _on_timer_timeout() -> void:
	canvas_layer.visible = true


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()
