
class_name MechbodyController
extends XRInputProcessor


@export var body : MechBody
@export var flight_effects : Node3D
@export var flight_controller : FlightModule

@export_category("stick movement")
@export var tranlation_mult = 0.5
@export var rotation_mult = 0.5

@export_category("headset tracking movement")
# look rotation / movement is in relation to this node 
@export var cockpit_headset_reference : Node3D
@export var look_rotation = true
@export var look_pitch = PI / 6
@export var look_yaw = PI / 4
@export var look_mult = 0.5


@export var lean_deadzone = 0.1
@export var lean_roll_mult = 2.0
@export var lean_input_mult = 5

var alt_look = false
var grounded = false

func _physics_process(delta):
	super._physics_process(delta)
	if !active: return
	if headset == null: return # TODO
	
	# reset inputs
	body.clear_inputs()
	
	# get inputs
	
	var rtrigger = rhand.get_float("trigger")
	var ltrigger = lhand.get_float("trigger")
	
	var primary = rhand.get_vector2("primary")
	var secondary = lhand.get_vector2("secondary")
	
	var rx = rhand.get_input("ax_button")
	var ry = rhand.get_input("by_button")
	
	var lx = lhand.get_input("ax_button")
	var ly = lhand.get_input("by_button")
	
	# STICK MOVEMENT
	
	body.front_input += secondary.y * tranlation_mult
	body.strafe_input += secondary.x * tranlation_mult
	
	if rx: body.climb_input -= 1
	if ry: body.climb_input += 1
	
	body.climb_input += rtrigger
	
	# rotation
	
	body.pitch_input += primary.y * rotation_mult
	
	# FLIGHT MODE
	
	if flight_controller.enabled:
		body.front_input = 1
		body.roll_input += primary.x * rotation_mult
	elif lx : 
		body.roll_input += primary.x
	else:
		body.roll_input += primary.x * rotation_mult
	
	# gadf
	
	if !alt_look and !flight_controller.enabled:
		
		# LOOK ROTATION
		
		# get angles from cockpit to headset
		# I'll think of how to use the proper node later TODO
		# for now assume headset is child of cockpit
		
		var x = headset.rotation.x
		var y = headset.rotation.y
		
		if abs(x) > look_pitch:
			body.pitch_input -= x * look_mult
		
		if abs(y) > look_yaw:
			body.yaw_input -= y * look_mult
		
		# LEAN ROLL
		
		var headset_pos = cockpit_headset_reference.to_local(headset.global_position)
		var headset_xz = Vector2(headset_pos.x, -headset_pos.z)
		
		if headset_xz.length_squared() > lean_deadzone * lean_deadzone:
			body.roll_input += (headset_xz.x ) * lean_roll_mult
	
	# GROUND MOVEMENT
	
	if ltrigger > 0.2:
		
		# LEAN MOVEMENT
		
		var headset_pos = cockpit_headset_reference.to_local(headset.global_position)
		var headset_xz = Vector2(headset_pos.x, -headset_pos.z)
		
		if headset_xz.length_squared() > lean_deadzone * lean_deadzone:
			body.front_input += (headset_xz.y - lean_deadzone) * lean_input_mult
			body.strafe_input += (headset_xz.x - lean_deadzone) * lean_input_mult
	



func _on_left_input_down(action):
	super._on_left_input_down(action)
	
	# FLIGHT MODE
	if action == "by_button":
		body.boost_forwards(0.02)
		#flight_effects.visible = true
		flight_controller.enabled = true
	
	# ALT LOOK
	if action == "ax_button":
		alt_look = true


func _on_left_input_up(action):
	super._on_left_input_up(action)
	
	# flight mode
	if action == "by_button":
		#flight_effects.visible = false
		flight_controller.enabled = false
		
	# ALT LOOK
	if action == "ax_button":
		alt_look = false


func _on_right_input_down(action):
	super._on_right_input_down(action)


func _on_right_input_up(action):
	super._on_right_input_up(action)

