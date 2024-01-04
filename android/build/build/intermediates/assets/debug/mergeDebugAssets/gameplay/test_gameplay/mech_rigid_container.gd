
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
	
	# left arm
	var larm = mechbody.cockpit.left_arm
	print(ragdoll_bit_u_arm)
	_set_bit($RagdollArmLeft/RagdollBitUArm, larm.uarm_ref)
	_set_bit($RagdollArmLeft/RagdollBitFArm, larm.farm_ref)
	_set_bit($RagdollArmLeft/RagdollBitHand, larm.hand_ref)
	
	# right arm
	var rarm = mechbody.cockpit.right_arm
	_set_bit($RagdollArmRight/RagdollBitUArm, rarm.uarm_ref)
	_set_bit($RagdollArmRight/RagdollBitFArm, rarm.farm_ref)
	_set_bit($RagdollArmRight/RagdollBitHand, rarm.hand_ref)


func _set_bit(bit, target):
	print("setting bit")
	bit.global_position = target.global_position
	bit.global_rotation = target.global_rotation
	bit.target_node = target
	
	if bit.pin != null:
		bit.pin.global_position = bit.global_position
