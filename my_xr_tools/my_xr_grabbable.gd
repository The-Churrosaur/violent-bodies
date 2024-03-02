
## Base class for grabbable pickups and diegetic input 'controllers'.
## Can be grabbed by a my_xr_hand_grabber (on a XRhand).
## If get_controller_input is true, can be a relay for controller input from that hand.
## controller has authority for grabbing and dropping.
## contains flags to request controller to grab/drop with special behavior.
## note - this method of control avoids having to wait for hands to load as global does.
## diegetic separation of concerns

class_name MyXRGrabbable
extends RigidBody3D



# FIELDS -----------------------------------------------------------------------



const XR_GRABBABLE_LAYER = 2

signal grabbed(grabber)
signal dropped(grabber)
signal hovered(grabber) # TODO

signal controller_input_pressed(action)
signal controller_input_released(action)
signal controller_float_changed(action, value)
signal controller_vec2_changed(action, value)

## if true, will act as a relay for controller input from the hand grabbing this
@export var get_controller_input = true

## if set false, changes collision layer to be invisible to hand_grabber
@export var grab_enabled = true:
	set(val): set_collision_layer_value(XR_GRABBABLE_LAYER, grab_enabled) 

## flags to request custom behavior from the xr_hand_grabber grabbing this
@export_group("Grabber Behavior Flags")

## drop on button release? this is simply a flag for xr_hand_grabber
@export var drop_on_release = true

## is not dropped by default grabber drop action. for ie. custom drop behavior
@export var ignore_drop = false


var controller : XRController3D = null
var hand_grabber : MyXRHandGrabber

var is_grabbed = false :
	get: return is_grabbed
	set(val): pass



# CALLBACKS --------------------------------------------------------------------



# -- CONTROLLER INPUT CALLBACKS


func _on_controller_button_pressed(action: String):
	controller_input_pressed.emit(action)


func _on_controller_button_released(action: String):
	controller_input_released.emit(action)


func _on_controller_float_changed(action: String, value: float):
	controller_float_changed.emit(action, value)


func _on_controller_vec2_changed(action: String, value: Vector2):
	controller_vec2_changed.emit(action, value)



# PUBLIC -----------------------------------------------------------------------



## call this to grab me with an xrhandgrabber
func grab_me(grabber : MyXRHandGrabber):
	_grab(grabber)


## drops this grabbable
func drop_me(grabber : MyXRHandGrabber):
	_drop(grabber)


# -- INPUT ENCAPSULATION FUNCTION


func controller_get_float(action : String) -> float:
	if controller == null: return 0
	else: return controller.get_float(action)


func controller_get_vec2(action : String) -> Vector2:
	if controller == null: return Vector2.ZERO
	else: return controller.get_vector2(action)


func controller_is_pressed(action : String) -> bool:
	if controller == null: return false
	else: return controller.is_button_pressed(action)



# PRIVATE ----------------------------------------------------------------------



func _setup_controller_input():
	controller.button_pressed.connect(_on_controller_button_pressed)
	controller.button_released.connect(_on_controller_button_released)
	controller.input_float_changed.connect(_on_controller_float_changed)
	controller.input_vector2_changed.connect(_on_controller_vec2_changed)


func _disconnect_controller_input():
	controller.button_pressed.disconnect(_on_controller_button_pressed)
	controller.button_released.disconnect(_on_controller_button_released)
	controller.input_float_changed.disconnect(_on_controller_float_changed)
	controller.input_vector2_changed.disconnect(_on_controller_vec2_changed)


func _grab(grabber):
	is_grabbed = true
	hand_grabber = grabber
	controller = grabber.controller
	_setup_controller_input()
	grabbed.emit(grabber)


func _drop(grabber):
	_disconnect_controller_input()
	controller = null
	hand_grabber = null
	is_grabbed = false
	dropped.emit(grabber)
