
## container for kinematic IK mech arm.
## moves IK target for rig.
## does some optional lerping on the IK target for smoothness 


class_name ArmBase
extends Node3D

@export var calibrate = false
@export var lerp_target = false
@export var lerp_shoulder = true
@export var target_lerp = 5
@export var shoulder_lerp = 5

@export_category("References")
@export var shoulder_node : Node3D = shoulder
@export var hand_parent : Node3D

@export_category("ugh")
@export var uarm_ref : Node3D
@export var farm_ref : Node3D
@export var hand_ref : Node3D

@onready var shoulder = $ShoulderJoint
@onready var shoulder_target = $ShoulderTarget
@onready var ik_target = $IKTarget


var target_node : Node3D  = null ## injected by arm_targeter


func _physics_process(delta):
	
	if target_node == null : return
	
	# lerp target
	
	if lerp_target:
		ik_target.global_transform = ik_target.global_transform.interpolate_with(target_node.global_transform, target_lerp * delta)
	else:
		ik_target.global_transform = target_node.global_transform
	
	# lerp shoulder
	
	if lerp_shoulder:
		# rotate shoulder target then lerp shoulder to target
		shoulder_target.global_rotation = target_node.global_rotation
		shoulder.global_transform = shoulder.global_transform.interpolate_with(shoulder_target.global_transform, shoulder_lerp * delta)
	else:
		shoulder.global_rotation = target_node.global_rotation
