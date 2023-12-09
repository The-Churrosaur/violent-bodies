# set as child of Shoulder
# takes handle
# follows handle's transform relative to shoulder 

# this node's transform will be copied and scaled by the arm


class_name HandleTarget
extends Node3D


@export var handle_arm : HandleArms


func _physics_process(delta):
	global_transform = handle_arm.handle.global_transform
