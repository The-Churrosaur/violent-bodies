
# triggers trigger
extends InputManager


@export var mech_hand : MechHand 


func _on_controller_button_pressed(str : String):
	
	$Label3D.text = "input detected: "+ str
	super._on_controller_button_pressed(str)
	
	if str == "trigger_click" : mech_hand.trigger_tool()
