
# holds and parents mech tools

class_name MechHand
extends Node3D


@export var current_tool : MechTool
@export var arm : ArmBase


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	# keeps self parented to hand
	global_transform = arm.hand_parent.global_transform
	#trigger_tool()
	#scale = Vector3.ONE


func trigger_tool():
	if current_tool != null:
		current_tool.trigger()
