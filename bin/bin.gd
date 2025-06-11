extends Area2D

@export var bin_type: BinType = BinType.TRASHBIN

@onready var sprite: Sprite2D = $Sprite2D
# SFX
@onready var life_lost = $life_lost
@onready var toss_recyclable = $toss_recyclable
@onready var toss_trash = $toss_trash

const PickupItem = preload("res://items/pickup_item.gd")

const Player = preload("res://player/player.gd")
var player: Player = null
var items_in_bin_count : int = 0

enum BinType { TRASHBIN, RECYCLINGBIN }

func _on_ready() -> void:
	match bin_type:
		BinType.TRASHBIN:
			sprite.texture = load("res://assets/bins/trash_bin.png")
		BinType.RECYCLINGBIN:
			sprite.texture = load("res://assets/bins/recycling_bin.png")
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body as Player
func _on_body_exited(body: Node2D) -> void:
	if body is Player and player == body:
		player = null

func _process(delta: float) -> void:
	if player and Input.is_action_just_pressed("putinbin"):
		if player.carrying_item:
			match player.current_item_type:
				PickupItem.ItemType.TRASH:
					if bin_type == BinType.TRASHBIN:
						toss_trash.play()
					else:
						life_lost.play()
						player.remove_planet()
						player.incorrect_bins += 1
				PickupItem.ItemType.RECYCLABLE:
					if bin_type == BinType.RECYCLINGBIN:
						toss_recyclable.play()
					else:
						life_lost.play()
						player.remove_planet()
						player.incorrect_bins += 1
			player.remove_item_from_hand()
			items_in_bin_count += 1
