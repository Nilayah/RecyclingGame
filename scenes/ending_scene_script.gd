extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var timer: Timer = $Timer


func _ready():
	canvas_layer.visible = false

func _on_timer_timeout() -> void:
	canvas_layer.visible = true
