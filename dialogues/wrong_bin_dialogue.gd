extends Area2D

@onready var label: Label = $Label

var step: int = 0
const Player = preload("res://player/player.gd")
var player: Player = null
var player_in_area: bool = false
var triggered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body as Player
		player_in_area = true

func _process(delta: float) -> void:
	if player_in_area and player:
		label.visible = player.current_health != 3
