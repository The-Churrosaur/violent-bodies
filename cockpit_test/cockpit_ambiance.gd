extends AudioStreamPlayer3D


@export var velocity_body : RigidBody3D
@export var pitch_velocity_coefficient = 0.02


func _physics_process(delta):
	pitch_scale = 1 + velocity_body.linear_velocity.length() * pitch_velocity_coefficient
