
## controls physical model / ik of control yoke handles 

class_name HandleArms
extends Node3D


@export var handle : YokeGrabbable

@export_group("Internal References")
@export var IK : SkeletonIK3D
@export var ik_target : Marker3D



func _ready():
	IK.start()


func _physics_process(delta):
	ik_target.global_position = handle.global_position
