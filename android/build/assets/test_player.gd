
# XROrigin base for player

class_name TestPlayer
extends XROrigin3D


@export var lhand : XRController3D
@export var rhand : XRController3D
@export var headset : XRCamera3D


func _ready():
	
	# populate globals
	XRPlayerGlobals.set_xr_nodes(lhand, rhand, headset, self)
	
	print("globals populated")



var flip = -1
func _on_timer_timeout():
	#position += Vector3(0,0.1,0) * flip
	#rotate_z(0.05 * flip)
	#flip = flip * -1
	
	pass
