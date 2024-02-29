
class_name MechTool
extends Node3D



# FIELDS -----------------------------------------------------------------------



## for parsing control inputs
var grabbable_controller : MyXRGrabbable :
	get: return grabbable_controller
	set(arg): return

## get is this tool active
var tool_active = false :
	get: return tool_active
	set(arg): return



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


## pass in a grabbable controller for this tool to parse input
func activate(grabbable_controller : MyXRGrabbable):
	
	tool_active = true
	self.grabbable_controller = grabbable_controller
	_connect_controller(grabbable_controller)


## disconnects this tool from grabbable
func deactivate():
	
	tool_active = false
	_disconnect_controller()
	grabbable_controller = null



# PRIVATE ----------------------------------------------------------------------



func _connect_controller(grabbable : MyXRGrabbable):
	grabbable.controller_input_pressed.connect(on_controller_input_pressed)
	grabbable.controller_input_released.connect(on_controller_input_released)


func _disconnect_controller():
	grabbable_controller.controller_input_pressed.disconnect(on_controller_input_pressed)
	grabbable_controller.controller_input_released.disconnect(on_controller_input_released)
