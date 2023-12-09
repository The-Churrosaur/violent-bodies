# TODO make arm the base node
# als0 this messy


class_name ArmTarget
extends RigidBody3D


@export var control_hand : HandleArms

# deprec
@export var control_origin : Node3D 
@export var control_scaling = 2.0

@export var lerp_amount = 20.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label3D.text = "ready"
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var target = control_hand.mech_target.global_transform
	$Label3D.text = str(target)
	global_transform = global_transform.interpolate_with(target, lerp_amount * delta)
	#$Label3D.text = "target"

