
## chain these to make a full physics ragdoll (with torque)
## grabs a target node to match rotation and velocity with


class_name RagdollBit
extends RigidBody3D


@export var target_node : Node3D

@onready var limb_rotator : LimbRotator = $LimbRotator


func _ready():
	
	# inject vars
	limb_rotator.target = target_node



func _process(delta):
	pass
