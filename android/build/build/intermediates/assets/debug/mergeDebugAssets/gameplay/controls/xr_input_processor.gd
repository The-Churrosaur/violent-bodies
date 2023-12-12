
# API for controller inputs
# inherit this to get input logic where you need it
# can be set active / inactive

class_name XRInputProcessor
extends Node3D


var lhand : XRController3D = null
var rhand : XRController3D = null
var headset : XRCamera3D = null

var active = true


func _ready():
	
	# wait for xr nodes to be set
	XRPlayerGlobals.connect("nodes_set", _on_globals_nodes_set)


func _on_globals_nodes_set():
	
	# get nodes
	lhand = XRPlayerGlobals.lhand
	rhand = XRPlayerGlobals.rhand
	headset = XRPlayerGlobals.headset
	
	# connect controller input signals
	lhand.connect("button_pressed", _on_left_input_down)
	lhand.connect("button_released", _on_left_input_up)
	rhand.connect("button_pressed", _on_right_input_down)
	rhand.connect("button_released", _on_right_input_up)


func _physics_process(delta):
	if headset == null : return
	if !active : return

func _on_left_input_down(action):
	if !active : return

func _on_left_input_up(action):
	if !active : return

func _on_right_input_down(action):
	if !active : return

func _on_right_input_up(action):
	if !active : return
