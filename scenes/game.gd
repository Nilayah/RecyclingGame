extends Node2D

@onready var timer: Timer = $Timer

@onready var press_e: Label = $Labels/PressE
@onready var bathroom: Label = $Labels/bathroom
@onready var press_space: Label = $Labels/PressSpace
@onready var use: Label = $Labels/Use
@onready var orLabel: Label = $Labels/or
@onready var to: Label = $Labels/to
@onready var move: Label = $Labels/move
@onready var e_key: Sprite2D = $Labels/EKey
@onready var w: Sprite2D = $Labels/W
@onready var a: Sprite2D = $Labels/A
@onready var s: Sprite2D = $Labels/S
@onready var d: Sprite2D = $Labels/D
@onready var down_arrow: Sprite2D = $Labels/DownArrow
@onready var left_arrow: Sprite2D = $Labels/LeftArrow
@onready var right_arrow: Sprite2D = $Labels/RightArrow
@onready var up_arrow: Sprite2D = $Labels/UpArrow
@onready var spacebar: Sprite2D = $Labels/Spacebar
@export var total_items := 2
var items_remaining := 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	press_e.visible = false
	bathroom.visible = false
	press_space.visible = false
	use.visible = false
	orLabel.visible = false
	to.visible = false
	move.visible = false
	e_key.visible = false
	w.visible = false
	a.visible = false
	s.visible = false
	d.visible = false
	down_arrow.visible = false
	left_arrow.visible = false
	right_arrow.visible = false
	up_arrow.visible = false
	spacebar.visible = false
	items_remaining = total_items
	
	timer.start()

func _on_timer_timeout() -> void:
	press_e.visible = true
	bathroom.visible = true
	press_space.visible = true
	use.visible = true
	orLabel.visible = true
	to.visible = true
	move.visible = true
	e_key.visible = true
	w.visible = true
	a.visible = true
	s.visible = true
	d.visible = true
	down_arrow.visible = true
	left_arrow.visible = true
	right_arrow.visible = true
	up_arrow.visible = true
	spacebar.visible = true
	
	timer.stop()
	
func items_gone():
	items_remaining -= 1
	if items_remaining <= 0:
		go_to_next_level()

func go_to_next_level():
	get_tree().change_scene_to_file("res://screens/loading_screen.tscn")
