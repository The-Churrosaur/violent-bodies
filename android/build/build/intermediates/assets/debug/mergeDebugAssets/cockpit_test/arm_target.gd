# lerps towards a target node
# target of ik arm


class_name ArmTarget
extends RigidBody3D


@export var lerp_amount = 20.0
@export var target_node : Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if target_node == null: return
	var target = target_node.global_transform
	global_transform = global_transform.interpolate_with(target, lerp_amount * delta)
	#$Label3D.text = "target"

