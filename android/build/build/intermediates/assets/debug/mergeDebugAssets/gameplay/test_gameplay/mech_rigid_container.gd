
@tool


## reeeeeeeeeeeee
## all rigidbodies need to be top level

extends Node3D

@export var mechbody : MechBody

@onready var ragdoll_bit_u_arm = $RagdollArmLeft/RagdollBitUArm

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		_set_positions()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _set_positions():
	print("setting positions")
	
	pass
