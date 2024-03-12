
## hacky replacement for sky shader since it causes terrible performance issues

class_name SkyDome
extends MeshInstance3D


@export var player_target : Node3D
@export var lerp_weight = 0.6

func _physics_process(delta):
	if player_target == null : return
	global_position = global_position.lerp(player_target.global_position, lerp_weight)
