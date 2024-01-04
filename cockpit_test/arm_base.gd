
# holds and acts as base for arm nodes

# takes handle target and shoulder position
# sets a position for armtarget to move to
# (set relative to shoulder)
# ik arms track off of arm target 


class_name ArmBase
extends Node3D

@export var calibrate = false

# to calculate target
@export var handle_target : HandleTarget
@export var scaling = 8.0
@export var shoulder_lerp = 5

@export_category("References")
# for access by others

@export var hand_parent : Node3D
@export var uarm_ref : Node3D
@export var farm_ref : Node3D
@export var hand_ref : Node3D

@onready var arm = $ShoulderJoint/arm
@onready var initial_target = $InitialTarget # desired arm target
@onready var shoulder = $ShoulderJoint
@onready var shoulder_target = $ShoulderTarget



func _process(delta):
	if calibrate:
		var stick_vec = XRPlayerGlobals.rhand.get_vector2("primary")
		scaling += stick_vec.x * 5 * delta 


func _physics_process(delta):
	
	# move target node
	initial_target.transform = handle_target.transform
	initial_target.position = initial_target.position * scaling
	
	# rotate shoulder joint
	# move shoulder target then lerp shoulder
	shoulder_target.global_rotation = initial_target.global_rotation
	shoulder.global_transform = shoulder.global_transform.interpolate_with(shoulder_target.global_transform, shoulder_lerp * delta)
	
