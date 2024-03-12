
## base class for cockpit virtual hud buttons

class_name VHUDButtonGrabbable
extends MyXRGrabbable


signal button_clicked()

@export var controller_action = "trigger_click"

@export_group("Internal References")
@export var animation_player : AnimationPlayer


func _on_controller_input_pressed(action):
	if action == controller_action: _press()


func _on_controller_input_released(action):
	if action == controller_action: _release()


func _hover(grabbable):
	super(grabbable)
	controller.trigger_haptic_pulse("haptic", 5, 0.1, 0.1, 0)


func _press():
	controller.trigger_haptic_pulse("haptic", 10, 0.3, 0.1, 0)
	animation_player.play("press")
	button_clicked.emit()


func _release():
	animation_player.play("release")
	

