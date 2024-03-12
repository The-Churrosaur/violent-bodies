class_name VHUDTestButton
extends VHUDButtonGrabbable

@export var tool_manager : MechHandToolManager
@export var weapon_label : Label3D

func _on_button_clicked():
	print("vhud button clicked")
	tool_manager.next_tool()
	weapon_label.text = tool_manager.current_tool.tool_name
