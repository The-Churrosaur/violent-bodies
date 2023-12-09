extends XRController3D

@onready var label = $MeshInstance3D/Label3D


func _on_button_pressed(name):
	label.text = "button pressed: " + name


func _on_input_float_changed(name, value):
	label.text = "input float: " + name + ", " + value


func _on_input_vector_2_changed(name, value):
	label.text = "vector changed: " + name + ", " + value
