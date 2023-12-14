extends Node3D

@export var mechcontroller : MechbodyController
@export var label : Label3D

func _on_interact_button_pressed(button):
	# toggle 
	mechcontroller.look_rotation = !mechcontroller.look_rotation
	print("LOOK BUTTON PRESSED: ", mechcontroller.look_rotation)
	if mechcontroller.look_rotation : 
		label.text = "DISABLE GAZE ROTATION"
	else:
		label.text = "ENABLE GAZE ROTATION"
