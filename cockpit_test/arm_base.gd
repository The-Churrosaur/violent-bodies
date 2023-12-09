
# holds and acts as base for arm nodes

# takes handle target and arm center 
# sets a position for armtarget to move to
# ik arms track off of arm target 


class_name ArmBase
extends Node3D

@export var calibrate = false

# to calculate target
@export var handle_target : HandleTarget
@export var arm_center : Node3D
@export var scaling = 8.0

@onready var arm = $ShoulderJoint/arm
@onready var initial_target = $InitialTarget # desired arm target


func _ready():
	
	# for transform reference from parent
	arm_center.add_child(initial_target)


func _process(delta):
	if calibrate:
		var stick_vec = XRPlayerGlobals.rhand.get_vector2("primary")
		scaling += stick_vec.x * 5 * delta 


func _physics_process(delta):
	
	# move target node
	initial_target.transform = handle_target.transform
	initial_target.position = initial_target.position * scaling
	
	# rotate shoulder joint
	$ShoulderJoint.global_rotation = initial_target.global_rotation
	
	$Label3D.text = str(scaling)
