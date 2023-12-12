
class_name MechbodyController
extends XRInputProcessor


@export var body : MechBody
@export var flight_effects : Node3D

# look rotation / movement is in relation to this node 
@export var cockpit_headset_reference : Node3D
@export var look_rotation = true
@export var look_pitch = PI / 6
@export var look_yaw = PI / 4


func _physics_process(delta):
	super._physics_process(delta)
	if headset == null: return # TODO
	
	# reset inputs
	body.clear_inputs()
	
	# get inputs
	
	var primary = rhand.get_vector2("primary")
	var secondary = lhand.get_vector2("secondary")
	
	var rx = rhand.get_input("ax_button")
	var ry = rhand.get_input("by_button")
	
	var lx = lhand.get_input("ax_button")
	var ly = lhand.get_input("by_button")
	
	# movement
	
	body.front_input += secondary.y
	body.strafe_input += secondary.x
	
	if ry: body.climb_input -= 1
	if rx: body.climb_input += 1
	
	# rotation
	
	body.pitch_input += primary.y
	
	# default roll, secondary yaw
	# (because headset movement)
	if lx : body.yaw_input += primary.x
	else : body.roll_input += primary.x
	
	# LOOK ROTATION
	
	if look_rotation:
		
		# get angles from cockpit to headset
		# I'll think of how to use the proper node later TODO
		# for now assume headset is child of cockpit
		
		var x = headset.rotation.x
		var y = headset.rotation.y
		
		if x > look_pitch : body.pitch_input -= 1
		if x < -look_pitch : body.pitch_input += 1
		
		if y > look_yaw : body.yaw_input -= 1
		if y < -look_pitch : body.yaw_input += 1


func _on_left_input_down(action):
	super._on_left_input_down(action)
	
	# boost
	if action == "by_button":
		body.boost_forwards(0.05)
		flight_effects.visible = true


func _on_left_input_up(action):
	super._on_left_input_up(action)
	
	# flight mode
	if action == "by_button":
		flight_effects.visible = false


func _on_right_input_down(action):
	super._on_right_input_down(action)


func _on_right_input_up(action):
	super._on_right_input_up(action)

