
# tracks health
class_name HealthModule
extends Node


signal health_zero()
@export var health = 5


func change_health(amount : int):
	health += amount
	if health <= 0 : emit_signal("health_zero")
