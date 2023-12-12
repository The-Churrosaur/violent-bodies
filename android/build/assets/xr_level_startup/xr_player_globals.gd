extends Node

# injected by player on startup - for reference and input acces

# nodes should just use this reference to make their own signal connections

#signal controller_input_pressed(name : String, controller : XRController3D)
#signal controller_input_released(name : String, controller : XRController3D)

signal nodes_set()

var lhand : XRController3D
var rhand : XRController3D
var headset : XRCamera3D

func set_xr_nodes(lhand : XRController3D, rhand : XRController3D, headset : XRCamera3D):
	self.lhand = lhand
	self.rhand = rhand
	self.headset = headset
	emit_signal("nodes_set")
