
## controls physical model / ik of control yoke handles 

class_name HandleArms
extends Node3D

@export var IK : SkeletonIK3D
@export var handle : Node3D

@export var yoke_position_tracker : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	IK.start()


func _physics_process(delta):
	yoke_position_tracker.global_transform = handle.global_transform
