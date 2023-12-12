
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
	transform = arm.hand_parent.transform


func trigger_tool():
	$Label3D.text = "mech hand activating tool"
	if current_tool != null:
		current_tool.trigger()
