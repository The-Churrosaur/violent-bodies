extends Node3D

@export var mechcontroller : MechbodyController

func _on_interact_button_pressed(button):
	# toggle 
	mechcontroller.look_rotation = !mechcontroller.look_rotation
	if mechcontroller.look_rotation : 
		$LookTurnButton/Label3D.text = "DISABLE GAZE ROTATION"
