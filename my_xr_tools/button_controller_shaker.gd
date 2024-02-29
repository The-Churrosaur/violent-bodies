
class_name ButtonControllershaker
extends Node

@export var joint_button : XRJointButton


func _on_joint_button_controller_entered(controller_body : ControllerBody):
	var controller = controller_body.xr_controller
	controller.trigger_haptic_pulse("haptic", 5, 0.1, 0.1, 0)
	pass


func _on_joint_button_controller_exited(controller_body : ControllerBody):
	pass # Replace with function body.


func _on_joint_button_demo_button_pressed():
	print("CONTROLLER BODIES: ")
	print(joint_button.contact_controller_bodies)
	for controller_body in joint_button.contact_controller_bodies.keys():
		var controller = controller_body.xr_controller
		print("BUZZING CONTROLLER: ", controller)
		controller.trigger_haptic_pulse("haptic", 10, 0.4, 0.1, 0)
	
	pass


func _on_joint_button_demo_button_released():
	pass # Replace with function body.
