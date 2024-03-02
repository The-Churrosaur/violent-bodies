
## connects information from the cockpit (shoulder and yoke) 
## to the arm - without exposing either.
## Sets child ArmTarget to arm target position and sends to arm


class_name ArmTargeter
extends Node3D

@export var active = true
@export var scaling = 32 ## ratio of player arm to mech arm

@export_group("References")
@export var player_shoulder : Node3D
@export var player_yoke : Node3D
@export var arm : ArmBase

@onready var arm_target = $ArmTarget

var target_pos = Vector3.ZERO


func _physics_process(delta):
	_calculate_target()


func _calculate_target():
	if !active: return
	
	var player_arm_vec = player_yoke.global_position - player_shoulder.global_position
	var shoulder_pos = arm.shoulder_node.global_position
	target_pos = shoulder_pos + player_arm_vec * scaling 
	
	arm_target.global_position = target_pos
	arm_target.global_rotation = player_yoke.global_rotation
	if arm.target_node == null: arm.target_node = arm_target
