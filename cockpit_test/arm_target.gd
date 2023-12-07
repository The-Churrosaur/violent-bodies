
class_name ArmTarget
extends RigidBody3D


@export var control_hand : Node3D

# deprec
@export var control_origin : Node3D 
@export var control_scaling = 2.0

@export var lerp_amount = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hand_disp = control_origin.to_local(control_hand.global_position)
	var target = control_origin.global_position + hand_disp * control_scaling
	
	global_position = global_position.lerp(target, delta * lerp_amount)
	rotation = rotation.lerp(control_hand.rotation, delta * lerp_amount)


