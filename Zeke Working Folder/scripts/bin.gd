extends Area2D

@export var bin_type: BinType = BinType.TRASHBIN

const PickupItem = preload("res://Nilayah's Working Folder/pickup_item.gd")

var player: Player = null

enum BinType { TRASHBIN, RECYCLINGBIN }

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
						print("You threw away trash")
					else:
						print("WRONG BIN!")
				PickupItem.ItemType.RECYCLABLE:
					if bin_type == BinType.RECYCLINGBIN:
						print("You recycled a plastic bottle")
					else:
						print("WRONG BIN!")
			player.remove_item_from_hand()
