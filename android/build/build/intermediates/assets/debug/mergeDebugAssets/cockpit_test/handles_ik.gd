class_name HandleArms
extends Node3D

@export var IK : SkeletonIK3D
@export var handle : Node3D



# Called when the node enters the scene tree for the first time.
func _ready():
	IK.start()

	
