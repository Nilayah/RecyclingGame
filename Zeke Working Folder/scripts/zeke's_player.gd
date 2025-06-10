extends CharacterBody2D

@onready var anim = $"zeke's_player_animations"

@export var SPEED = 100
@export var animation_tree : AnimationTree

var input_direction : Vector2
var playback : AnimationNodeStateMachinePlayback

func _ready():
	playback = animation_tree["parameters/playback"]

# Actual movement
func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED

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

func _physics_process(_delta):
	get_input()
	move_and_slide()
	select_animation()
	update_animation_parameters()
