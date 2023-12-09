# testing input and movement

class_name MechBody
extends RigidBody3D

@export var thrust_power = 500000.0
@export var torque_power = 50000.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	
	var primary = XRPlayerGlobals.rhand.get_vector2("primary")
	var secondary = XRPlayerGlobals.lhand.get_vector2("secondary")
	
	var fore = transform.basis.z
	var right = transform.basis.x 
	var up = transform.basis.y
	
	apply_central_force(right * thrust_power * delta * secondary.x)
	apply_central_force(fore * -thrust_power * delta * secondary.y)
	
	apply_torque(up * -torque_power * delta * primary.x)
	apply_torque(right * -torque_power * delta * primary.y)
	
	$Label3D.text = str(linear_velocity)
	$Label3D2.text = str(secondary)
