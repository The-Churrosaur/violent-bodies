
class_name BasicMechGun
extends MechTool

@export var gun : StupidGun
@export var trigger_action : String = "trigger"

func on_controller_input_pressed(action):
	super(action)
	if action == trigger_action: gun.pull_trigger()

func on_controller_input_released(action):
	super(action)
	if action == trigger_action: gun.release_trigger()
