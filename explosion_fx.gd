
class_name ExplosionFX
extends Node3D

@export var boom_delay = 5.0


func start_explosion_sequence():
	$bubbling.emitting = true
	$Timer.start(boom_delay)


func explode_nova():
	$nova.emitting = true


func _on_timer_timeout():
	explode_nova()
