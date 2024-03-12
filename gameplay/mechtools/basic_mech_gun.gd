
class_name BasicMechGun
extends MechTool

@export var gun : StupidGun
@export var trigger_action : String = "trigger_click"
@export var launching_rigidbody : RigidBody3D


func _ready():
	super()
	gun.launching_rigidbody = launching_rigidbody


func on_controller_input_pressed(action):
	super(action)
	if action == trigger_action: gun.pull_trigger()

func on_controller_input_released(action):
	super(action)
	if action == trigger_action: gun.release_trigger()


func _on_stupidgun_firing():
	print("firing haptic")
	grabbable_controller.controller.trigger_haptic_pulse("haptic", 5, 0.4, 0.2, 0)
