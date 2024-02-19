extends Node3D
@onready var label_3d = $Label3D


func _on_joint_button_demo_button_pressed(contact_items):
	label_3d.text = "BUTTON PRESSED"
	print("test button pressed")


func _on_joint_button_demo_button_released(contact_items):
	label_3d.text = "BUTTON RELEASED"
