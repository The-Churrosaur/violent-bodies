

# ONE HAND input management for a particular pickable
# just for organization

class_name PickableInputManager
extends Node3D


@export var active = false
var controller : XRController3D


func _on_grabbed(pickable, by):
	
	# assuming this works
	controller = by.get_parent()
	
	controller.button_pressed.connect(_on_controller_button_pressed)
	controller.button_pressed.connect(_on_controller_button_released)
	
	active = true


func _on_released(pickable):
	
	controller.button_pressed.disconnect(_on_controller_button_pressed)
	controller.button_pressed.disconnect(_on_controller_button_released)
	
	controller = null
	active = false


# inhereted managers are beholden to active
func _on_controller_button_pressed(str : String):
	if !active: return

func _on_controller_button_released(str : String):
	if !active: return

func _process(delta):
	if !active: return
