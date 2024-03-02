
## simple rigidbody encapsulator. On ready, childs self to the level root.
## (allows rigidbody to be organized as child in scenetree).
## DO NOT USE for bodies that are being joined, use reparenting_joint
## TODO make this work

class_name ReparentingRigidbody3D
extends RigidBody3D


func _ready():
	reparent(LevelGlobals.level)
