extends CharacterBody2D

@export var SPEED = 100
@onready var pick_up = load("res://Nilayah's Working Folder/pickup_item.tscn")
@onready var item_spr: Sprite2D = $ItemSprite

var carrying_item: bool = false
var drop_pos: Vector2
var items_in_range: Array = []

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED

func _physics_process(delta):
	get_input()
	move_and_slide()

func _on_ready() -> void:
	# Pick Up
	item_spr.hide() 

#Pick Up
func pickup_item(item: Area2D):
	item.queue_free()
	carrying_item = true
	item_spr.show()

func drop_item():
	item_spr.hide()
	var item = pick_up.instantiate()
	item.position = position + drop_pos
	item.position.y += 10
	get_parent().add_child(item)
	carrying_item = false
	
func _on_pick_up_range_area_entered(area: Area2D) -> void:
	if area.is_in_group("pick_up"):
		items_in_range.append(area)

func _on_pick_up_range_area_exited(area: Area2D) -> void:
	if area.is_in_group("pick_up"):
		items_in_range.erase(area)
		
func _input(event):
	if event.is_action_pressed("pickup"):
		if carrying_item:
			drop_item()
		else:
			if !items_in_range.is_empty():
				pickup_item(items_in_range.pick_random())
