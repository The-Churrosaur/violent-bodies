class_name PullThruster
extends Node3D



@export var thrust = 5000


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func pull(mechbody):
	var direction = global_position - mechbody.global_position
	mechbody.apply_central_force(direction * thrust)
