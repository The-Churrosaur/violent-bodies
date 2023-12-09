class_name HandleArms
extends Node3D

@export var IK : SkeletonIK3D
@export var mech_target : Node3D
@export var headset : XRCamera3D

@export var target_reference : Node3D
@export var handle : Node3D
@export var target_offset_coefficient = 2.0
@export var target_min_distance = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	IK.start()

func _process(delta):
	
	# sets mech target position depending on proximity to headset
	
	var closeness = handle.global_position - headset.global_position
	var scaling = closeness.length_squared() * target_offset_coefficient
	$Handles/MechTargetReference/Label3D.text = str(scaling)
	
	# scales its position respective to the reference
	# both have the same parent
	mech_target.position = target_reference.position * scaling
	
