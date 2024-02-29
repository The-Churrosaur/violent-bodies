extends Node

# injected by player on startup - for reference and input acces

# nodes should just use this reference to make their own signal connections
signal controller_input_pressed(name : String, controller : XRController3D)
signal controller_input_released(name : String, controller : XRController3D)

signal nodes_set()




enum CONTROLLERS {LHAND, RHAND, HEADSET, ORIGIN} # APPEND THIS LIST AS NECESSARY

var _controller_dict= {} # maps enums to objects for internal use

var lhand : XRController3D
var rhand : XRController3D
var headset : XRCamera3D
var origin : XROrigin3D

func set_xr_nodes(lhand : XRController3D,\
				  rhand : XRController3D,\
				headset : XRCamera3D, \
				 origin : XROrigin3D):
	
	self.lhand = lhand
	self.rhand = rhand
	self.headset = headset
	self.origin = origin
	
	
	
	emit_signal("nodes_set")

func get_input(action : String, controller : CONTROLLERS):
	pass
