
# makes the ship go whee
# align this with the axis of flight you want

class_name FlightModule
extends Node3D


@export var mechbody : RigidBody3D
@export var coefficient = 1.2
@export var max_aoa = PI / 2
@export var enabled = false
@export var max_force = 10000  

@onready var ball = $MeshInstance3D

var data : String


func _physics_process(delta):
	if !enabled: return
	
	var fore = -global_transform.basis.z
	var vel = mechbody.linear_velocity
	var alpha = fore.signed_angle_to(vel, -global_transform.basis.x)
	
	if alpha > max_aoa: 
		data = "stalls"
		return
	if vel.dot(fore) < 0: 
		data = "vectors opposite"
		return 
	
	var lift = global_transform.basis.y * alpha * coefficient * vel.length_squared()
	
	if lift.length_squared() > max_force * max_force:
		lift = lift.normalized() * max_force
	
	mechbody.apply_central_force(lift)
	
	var length = lift.length()
	data = str(int(length))
	
	ball.position = lift / 1000
