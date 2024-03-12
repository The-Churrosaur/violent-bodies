
class_name MechTool
extends Node3D



# FIELDS -----------------------------------------------------------------------


## for HUD 
@export var tool_name = "TOOL"

## for parsing control inputs
var grabbable_controller : MyXRGrabbable

## get is this tool active
var tool_active = false



# CALLBACKS --------------------------------------------------------------------



func _ready():
	pass
	

func on_controller_input_pressed(action):
	pass


func on_controller_input_released(action):
	pass



# PUBLIC -----------------------------------------------------------------------



# DEPRECIATED API for trigger tools
func press_trigger():
	pass


func release_trigger():
	pass


func trigger():
	press_trigger()
	release_trigger()


## pass in a grabbable controller for this tool to parse input
func activate(controller : MyXRGrabbable):
	
	tool_active = true
	grabbable_controller = controller
	_connect_controller(grabbable_controller)


## disconnects this tool from grabbable
func deactivate():
	
	tool_active = false
	_disconnect_controller()
	print("setting controller null")
	grabbable_controller = null



# PRIVATE ----------------------------------------------------------------------



func _connect_controller(grabbable : MyXRGrabbable):
	print("tool connecting controller ", grabbable)
	grabbable.controller_input_pressed.connect(on_controller_input_pressed)
	grabbable.controller_input_released.connect(on_controller_input_released)


func _disconnect_controller():
	print("tool disconnecting controller ", grabbable_controller)
	grabbable_controller.controller_input_pressed.disconnect(on_controller_input_pressed)
	grabbable_controller.controller_input_released.disconnect(on_controller_input_released)
