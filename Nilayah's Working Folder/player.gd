extends CharacterBody2D

class_name Player

@export var SPEED = 100

@onready var pick_up = load("res://Nilayah's Working Folder/pickup_item.tscn")
@onready var item_spr: Sprite2D = $ItemSprite

var carrying_item: bool = false
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

#Pick Up / Drop Item
func pickup_item():
	carrying_item = true
	item_spr.show()

func drop_item():
	remove_item_from_hand()
	var item = pick_up.instantiate()
	item.position = position + drop_pos
	#item.position.y += 10
	get_parent().add_child(item)
	
func remove_item_from_hand():
	item_spr.hide()
	carrying_item = false
