
class_name ExplosionFX
extends Node3D

signal explosion_ended()
@export var boom_delay = 5.0

var total_time = boom_delay + 6

func start_explosion_sequence():
	$bubbling.emitting = true
	$Timer.start(boom_delay)
	$end.start(total_time)


func explode_nova():
	$nova.emitting = true


func _on_timer_timeout():
	explode_nova()


func _on_end_timeout():
	emit_signal("explosion_ended")
