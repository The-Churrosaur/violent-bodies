
@tool


## reeeeeeeeeeeee
## all rigidbodies need to be top level

extends Node3D

@export var mechbody : MechBody

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		_set_positions()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _set_positions():
	print("setting positions")
	$LHandBit.global_position = mechbody.cockpit.left_arm.hand_ref.global_position
	$RHandBit.global_position = mechbody.cockpit.right_arm.hand_ref.global_position
	pass
