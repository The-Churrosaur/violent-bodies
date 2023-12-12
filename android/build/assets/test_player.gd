
# XROrigin base for player

class_name TestPlayer
extends XROrigin3D


@export var lhand : XRController3D
@export var rhand : XRController3D
@export var headset : XRCamera3D


func _ready():
	
	# populate globals
	XRPlayerGlobals.set_xr_nodes(lhand, rhand, headset)
	
	print("globals populated")
