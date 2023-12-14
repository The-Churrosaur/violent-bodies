
class_name ExplosionFX
extends Node3D

signal explosion_ended()
@export var boom_delay = 5.0

@export var bubbling : GPUParticles3D
@export var nova : GPUParticles3D


func start_explosion_sequence():
	bubbling.emitting = true


func _on_bubbling_finished():
	nova.emitting = true


func _on_nova_finished():
	emit_signal("explosion_ended")



