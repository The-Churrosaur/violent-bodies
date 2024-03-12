
class_name Shield
extends MechTool

@export var controller_action = "trigger_click"


@onready var mesh_instance_3d = $MeshInstance3D
@onready var area_3d = $Area3D


func on_controller_input_pressed(action):
	super(action)
	if action == controller_action: _shield_on()


func on_controller_input_released(action):
	super(action)
	if action == controller_action: _shield_off()


func _shield_on():
	mesh_instance_3d.visible = true
	area_3d.monitorable = true

func _shield_off():
	mesh_instance_3d.visible = false
	area_3d.monitorable = false

