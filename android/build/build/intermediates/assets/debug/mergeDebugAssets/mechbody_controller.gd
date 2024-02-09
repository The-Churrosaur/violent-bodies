
class_name MechbodyController
extends XRInputProcessor


@export var body : MechBody
@export var flight_effects : Node3D
@export var flight_controller_pitch : FlightModule
@export var flight_controller_yaw : FlightModule
@export var pull_thruster : PullThruster
@export var arm_aimer_hand_remote : Node3D

@export_category("stick movement")
@export var tranlation_mult = 0.5
@export var rotation_mult = 0.5

@export_category("headset tracking movement")
# look rotation / movement is in relation to this node 
@export var cockpit_headset_reference : Node3D
@export var look_rotation = true
@export var look_pitch = PI/16
@export var look_yaw = PI/16
@export var look_mult = 0.5

@export var lean_deadzone = 0.05
@export var lean_roll_mult = 2.0
@export var lean_input_mult = 1
@export var lean_pitch_mult = 1.0

#@export var arm_wing_deadzone = 0.1
#@export var arm_wing_roll_mult = 1
#@export var arm_wing_yaw_mult = 0.3
#@export var arm_wing_pitch_deadzone = 0.05
#@export var arm_wing_pitch_mult = 3
#@export var arm_wing_thrust_mult = 1
#@export var arm_wing_speed_div = 100

@onready var arm_center = $ArmCenter ## points towards left hand
@onready var arm_center_reference = $ArmCenterReference
@onready var arm_aimer = $ArmAimer

var alt_look = false
var is_flight = false


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
	
	#body.climb_input += rtrigger
	
	# rotation
	
	body.pitch_input += primary.y * rotation_mult
	body.roll_input += primary.x * rotation_mult
	
	# gadf
	
	if !alt_look:
		
		# LOOK ROTATION
		
		# get angles from cockpit to headset
		# I'll think of how to use the proper node later TODO
		# for now assume headset is child of cockpit
		
		var x = headset.rotation.x
		var y = headset.rotation.y
		
		# TODO testing arm following
		if ltrigger > 0:
			
			arm_aimer.look_at(arm_aimer_hand_remote.global_position)
			x += arm_aimer.rotation.x
			y += arm_aimer.rotation.y
		
		
		if abs(x) > look_pitch:
			body.pitch_input -= x * look_mult
		
		if abs(y) > look_yaw:
			body.yaw_input -= y * look_mult
		
		# LEAN ROLL
		
		if !body.is_landed:
			
			var headset_pos = cockpit_headset_reference.to_local(headset.global_position)
			var headset_xz = Vector2(headset_pos.x, -headset_pos.z)
			
			if headset_xz.length_squared() > lean_deadzone * lean_deadzone:
				body.roll_input += (headset_xz.x ) * lean_roll_mult
				body.pitch_input += headset_xz.y * lean_pitch_mult
	
	# GROUND MOVEMENT
	
	if body.is_landed:
		
		# LEAN MOVEMENT
		
		var headset_pos = cockpit_headset_reference.to_local(headset.global_position)
		var headset_xz = Vector2(headset_pos.x, -headset_pos.z)
		
		if headset_xz.length_squared() > lean_deadzone * lean_deadzone:
			body.front_input += (headset_xz.y - lean_deadzone) * lean_input_mult
			body.strafe_input += (headset_xz.x - lean_deadzone) * lean_input_mult
	
	# ARM WINGS
	
	#var lshoulder = body.left_player_shoulder.global_position
	#var rshoulder = body.right_player_shoulder.global_position
	#arm_center_reference.global_position = (lshoulder + rshoulder) / 2
	#
	#var midpoint = (rhand.global_position + lhand.global_position) / 2
	#var up = body.global_transform.basis.y
	#
	#arm_center.look_at_from_position(midpoint, lhand.global_position, up)
	
	if is_flight:
		
		#var speed = abs(body.linear_velocity.length())
		#var s = speed / arm_wing_speed_div
		#
		#var roll = arm_center.rotation.x
		#if abs(roll) > arm_wing_deadzone:
			#body.roll_input += roll * arm_wing_roll_mult * s
		#
		#var yaw = - arm_center.rotation.y + PI/2 # armcenter is rotated
		#if abs(yaw) > arm_wing_deadzone:
			#body.yaw_input += yaw * arm_wing_yaw_mult * s
		#
		#var pitch = arm_center_reference.position.y - arm_center.position.y
		#if abs(pitch) > arm_wing_pitch_deadzone:
			#body.pitch_input += pitch * arm_wing_pitch_mult * s
			#flight_controller_pitch.rotation.x = -pitch # rotates correctly, something wrong with wings
		
		# thrust
		#var length = (rhand.global_position - lhand.global_position).length()
		#var thrust = length * arm_wing_thrust_mult
		#body.front_input += thrust
		
		pull_thruster.pull(body)
	
	if ltrigger > 0: 
		
		pull_thruster.pull(body)


func _on_left_input_down(action):
	super._on_left_input_down(action)
	
	# FLIGHT MODE
	if action == "by_button":
		body.boost_forwards(0.02)
		#flight_effects.visible = true
		_enter_flight()
	
	# ALT LOOK
	if action == "ax_button":
		alt_look = true


func _on_left_input_up(action):
	super._on_left_input_up(action)
	
	# flight mode
	if action == "by_button":
		#flight_effects.visible = false
		_exit_flight()
		
	# ALT LOOK
	if action == "ax_button":
		alt_look = false


func _on_right_input_down(action):
	super._on_right_input_down(action)


func _on_right_input_up(action):
	super._on_right_input_up(action)


func _enter_flight():
	is_flight = true
	flight_controller_pitch.enabled = true
	flight_controller_yaw.enabled = true

func _exit_flight():
	is_flight = false
	flight_controller_pitch.enabled = false
	flight_controller_yaw.enabled = false
