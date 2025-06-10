extends CharacterBody2D

class_name Player

@onready var pick_up = load("res://Nilayah's Working Folder/pickup_item.tscn")
@onready var item_spr: Sprite2D = $ItemSprite

@export var SPEED = 100
@onready var animation_tree: AnimationTree = $AnimationTree

const PickupItem = preload("res://Nilayah's Working Folder/pickup_item.gd")

var carrying_item: bool = false
var current_item_type: PickupItem.ItemType = PickupItem.ItemType.TRASH
var drop_pos := Vector2(0, 16)
var items_in_range: Array = []

var input_direction : Vector2
var last_direction = Vector2.DOWN
var playback : AnimationNodeStateMachinePlayback

func _ready():
	# Pick Up / Drop Item
	item_spr.hide() 
	
	# Animation
	playback = animation_tree["parameters/playback"]

func _physics_process(_delta):
	get_input()
	move_and_slide()
	select_animation()
	update_animation_parameters()
	
# Movement
func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction != Vector2.ZERO: # used chatgpt to figure out direction of character
		last_direction = input_direction.normalized()
	velocity = input_direction * SPEED
	
	# Drop Item
	if Input.is_action_just_pressed("pickup") and carrying_item == true:
		drop_item()

# Animation
func update_animation_parameters():
	if input_direction == Vector2.ZERO:
		return
	
	animation_tree["parameters/idle/blend_position"] = input_direction
	animation_tree["parameters/walk/blend_position"] = input_direction
	
func select_animation():
	if velocity == Vector2.ZERO:
		playback.travel("idle")
	else:
		playback.travel("walk")
	if carrying_item == true:
		if last_direction.y < -0.5:
			item_spr.hide()
		elif last_direction.x > 0.5 and last_direction.y == 0:
			item_spr.show()
			item_spr.position = Vector2(5, 4)
		elif last_direction.x < -0.5 and last_direction.y == 0:
			item_spr.show()
			item_spr.position = Vector2(-5, 4)
		else:
			item_spr.show()
			item_spr.position = Vector2(0, 4)

# Pick Up / Drop Item - used a youtube video to learn how to pick up and drop items
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
