
class_name ButtonControllershaker
extends Node

@export var joint_button : XRJointButton


func _on_joint_button_controller_entered(controller_body : ControllerBody):
	var controller = controller_body.xr_controller
	controller.trigger_haptic_pulse("haptic", 5, 0.2, 0.1, 0)


func _on_joint_button_controller_exited(controller_body : ControllerBody):
	pass # Replace with function body.


func _on_joint_button_demo_button_pressed(contact_items):
	
	for controller_body in joint_button.contact_controller_bodies:
		var controller = controller_body.xr_controller
		controller.trigger_haptic_pulse("haptic", 10, 0.4, 0.1, 0)
	
	pass # Replace with function body.


func _on_joint_button_demo_button_released(contact_items):
	pass # Replace with function body.
