
## takes a target skeleton an a physics skeleton and applies forces to 
## match physicalbone positions to the target 

class_name ActiveRagdoll
extends Node3D


@export var target_skeleton : Skeleton3D
@export var physics_skeleton : Skeleton3D


var physics_bones : Array[PhysicalBone3D]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass


func _apply_rotation_force(axis, degree_delta):
	pass

func _apply_translation_force():
	pass
