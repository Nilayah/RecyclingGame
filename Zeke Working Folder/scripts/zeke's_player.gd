extends CharacterBody2D

@onready var anim = $"zeke's_player_animations"

@export var SPEED = 200

enum Carrying {
	EMPTY,
	RECYCLING,
	TRASH
}

enum MovementState {
	IDLE,
	UP,
	DOWN,
	LEFT,
	RIGHT
}


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED

func _physics_process(_delta):
	get_input()
	move_and_slide()
