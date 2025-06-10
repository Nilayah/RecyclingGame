extends CharacterBody2D

class_name Player

@export var SPEED = 100

@onready var pick_up = load("res://Nilayah's Working Folder/pickup_item.tscn")
@onready var item_spr: Sprite2D = $ItemSprite

const PickupItem = preload("res://Nilayah's Working Folder/pickup_item.gd")

var carrying_item: bool = false
var current_item_type: PickupItem.ItemType = PickupItem.ItemType.TRASH
var drop_pos := Vector2(0, 16)
var items_in_range: Array = []

func _on_ready() -> void:
	# Pick Up / Drop Item
	item_spr.hide() 

func _physics_process(delta):
	get_input()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pickup") and carrying_item == true:
		drop_item()

# Movement
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED

#Pick Up / Drop Item - used a youtube video to learn how to pick up and drop items
func pickup_item(item_type):
	carrying_item = true
	current_item_type = item_type
	match item_type:
		PickupItem.ItemType.TRASH:
			item_spr.region_rect = Rect2(205, 14, 37, 50)
		PickupItem.ItemType.RECYCLABLE:
			item_spr.region_rect = Rect2(1, 15, 17, 49)
	item_spr.show()

func drop_item():
	remove_item_from_hand()
	var item = pick_up.instantiate()
	item.item_type = current_item_type
	item.position = position + drop_pos
	get_parent().add_child(item)
	
func remove_item_from_hand():
	item_spr.hide()
	carrying_item = false
