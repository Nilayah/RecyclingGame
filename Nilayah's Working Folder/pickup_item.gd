extends Area2D

var player: Player = null
@onready var pickup_item: Area2D = $"."

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body as Player

func _on_body_exited(body: Node2D) -> void:
	if body is Player and player == body:
		player = null

func _process(delta: float) -> void:
	if player and Input.is_action_just_pressed("pickup"):
		if player.carrying_item == false:
			queue_free()
			player.pickup_item()
