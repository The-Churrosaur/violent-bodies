
## chain these to make a full physics ragdoll (with torque)
## grabs a target node to match rotation and velocity with


class_name RagdollBit
extends RigidBody3D


@export var target_node : Node3D
@export var pin : PinJoint3D

@onready var limb_rotator : LimbRotator = $LimbRotator


func _ready():
	
	# inject vars
	limb_rotator.target = target_node
	
	# TODO - this is not good and breaks pins
	#await get_tree().process_frame
	#reparent(LevelGlobals.level)
	
	print(get_parent_node_3d())
	


func _process(delta):
	pass

