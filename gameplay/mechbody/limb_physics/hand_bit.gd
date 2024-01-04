extends Node3D

@export var mechbody : MechBody
@export var hand : RigidBody3D
@export var anchor : RigidBody3D
@export var hands : UtilityGlobals.hands

@onready var limb_rotator = $Hand/LimbRotator

var target = null


#TODO clean up these references

func _physics_process(delta):
	
	if hands == UtilityGlobals.hands.RIGHT: 
		target = mechbody.right_arm_targeter
	else: 
		target = mechbody.left_arm_targeter 
	
	anchor.global_transform = target.arm_target.global_transform
	hand.global_rotation = target.arm_target.global_rotation
	
	target.arm.target_node = hand
	
	# equal and opposite
	if limb_rotator.recoil_body == null:
		limb_rotator.recoil_body = mechbody
	
