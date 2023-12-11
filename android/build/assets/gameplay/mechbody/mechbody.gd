# testing input and movement

class_name MechBody
extends RigidBody3D

@export var thrust_power = 500000.0
@export var torque_power = 180000.0

var wing_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	
	var trigger = XRPlayerGlobals.lhand.get_input("trigger_click")
	if trigger: 
		var trackers = XRServer.get_trackers(2)
		trackers[0].set_input("haptic", 0.5)
	
	var primary = XRPlayerGlobals.rhand.get_vector2("primary")
	var secondary = XRPlayerGlobals.lhand.get_vector2("secondary")
	
	var rx = XRPlayerGlobals.rhand.get_input("ax_button")
	var ry = XRPlayerGlobals.rhand.get_input("by_button")
	
	var lx = XRPlayerGlobals.lhand.get_input("ax_button")
	var ly = XRPlayerGlobals.lhand.get_input("by_button")
	
	var fore = transform.basis.z
	var right = transform.basis.x 
	var up = transform.basis.y
	
	apply_central_force(right * thrust_power * delta * secondary.x)
	apply_central_force(fore * -thrust_power * delta * secondary.y)
	if rx:
		apply_central_force(up * thrust_power * delta)
	if ry:
		apply_central_force(up * -thrust_power * delta)
	
	# pitch
	apply_torque(right * -torque_power * delta * primary.y)
	
	# plane mode
	if ly:
		# stick is roll
		apply_torque(fore * -torque_power * delta * primary.x)
		$wingfx.visible = true
		apply_central_force(fore * -thrust_power * delta)
		if !wing_mode: apply_central_impulse(-fore * 10000)
		wing_mode = true
		
	
	# normal
	else:
		# if ly is pressed, py is roll, else yaw
		if (lx):
			apply_torque(fore * -torque_power * delta * primary.x)
		else:
			apply_torque(up * -torque_power * delta * primary.x)
		
		$wingfx.visible = false
		wing_mode = false
	
	
	# trying head rotation
	var head = XRPlayerGlobals.headset
	if head.rotation.x > PI/4:
		apply_torque(right * torque_power * delta)
	if head.rotation.x < -PI/4:
		apply_torque(right * -torque_power * delta)
	
	
	$Label3D.text = str(linear_velocity)
	$Label3D2.text = str(secondary)
