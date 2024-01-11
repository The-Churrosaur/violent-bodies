# physical movement of the mech
# set input attributes with controller

class_name MechBody
extends RigidBody3D

signal landed()
signal takeoff()

@export var thrust_power = 500000.0
@export var torque_power = 180000.0

@export_category("references")
@export var cockpit : Cockpit
@export var left_arm_targeter : ArmTargeter
@export var right_arm_targeter : ArmTargeter
@export var left_player_shoulder : Node3D
@export var right_player_shoulder : Node3D

# set by controller
# assume 0-1 but it's multiplicative
var pitch_input = 0
var roll_input = 0
var yaw_input = 0

var front_input = 0
var strafe_input = 0
var climb_input = 0

var fore
var right
var up

var is_landed = false


func _physics_process(delta):
	
	fore = transform.basis.z
	right = transform.basis.x 
	up = transform.basis.y
	
	# strafe
	apply_central_force(right * thrust_power * delta * strafe_input)
	# fore/reverse
	apply_central_force(fore * -thrust_power * delta * front_input)
	# climb
	apply_central_force(up * thrust_power * delta * climb_input)
	
	# pitch
	apply_torque(right * -torque_power * delta * pitch_input)
	# roll
	apply_torque(fore * -torque_power * delta * roll_input)
	# yaw
	apply_torque(up * -torque_power * delta * yaw_input)


func boost_forwards(mult = 1.0):
	apply_central_impulse(fore * -thrust_power * mult)


func clear_inputs():
	
	pitch_input = 0
	roll_input = 0
	yaw_input = 0
	
	front_input = 0
	strafe_input = 0
	climb_input = 0


func _on_body_entered(body):
	print("body entered")
	if body.is_in_group("ground"): 
		print("GROUNDED")
		landed.emit()
		is_landed = true


func _on_body_exited(body):
	if body.is_in_group("ground"): 
		takeoff.emit()
		is_landed = false
