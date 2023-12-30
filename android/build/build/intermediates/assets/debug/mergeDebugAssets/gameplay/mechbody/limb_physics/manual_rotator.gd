extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"): rotate_x(0.01)
	if Input.is_action_pressed("ui_left"): rotate_x(-0.01)
	
	if Input.is_action_pressed("ui_up"): rotate_y(0.01)
	if Input.is_action_pressed("ui_down"): rotate_y(-0.01)


func _input(event):
	#if event.is_action_pressed("ui_right"): rotate_x(0.1)
	#if event.is_action_pressed("ui_left"): rotate_x(-0.1)
	
	#if event.is_action("ui_up"): rotate_y(0.1)
	#if event.is_action("ui_"): rotate_y(-0.1)
	
	pass
