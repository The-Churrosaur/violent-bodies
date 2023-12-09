extends Node3D

@export var calibrate = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	
	if calibrate:
	
		var stick_vec = XRPlayerGlobals.rhand.get_vector2("secondary")
		position.y += stick_vec.x * 5 * delta 
	
		$Label3D.text = str(position.y)
		$MeshInstance3D.visible = true
		
