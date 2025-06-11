extends Area2D

@onready var pickup_item: Area2D = $"."
@onready var sprite: Sprite2D = $Sprite2D
@onready var pickup_sfx_animation = $pickup_sfx_animation

@export var item_type: ItemType = ItemType.TRASH

# used chatgpt to learn how to use enums
enum ItemType { TRASH, RECYCLABLE }

var player: Player = null

func _ready():
	match item_type:
		ItemType.TRASH:
			sprite.region_rect = Rect2(205, 14, 37, 50)
		ItemType.RECYCLABLE:
			sprite.region_rect = Rect2(1, 15, 17, 49)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body as Player

func _on_body_exited(body: Node2D) -> void:
	if body is Player and player == body:
		player = null

func _process(delta: float) -> void:
	if player and Input.is_action_just_pressed("pickup"):
		if player.carrying_item == false:
			player.pickup_item(item_type)
			# queue_free() exists in the sfx animations
			match item_type:
				ItemType.TRASH:
					pickup_sfx_animation.play("pickup_trash")
				ItemType.RECYCLABLE:
					pickup_sfx_animation.play("pickup_recyclable")
