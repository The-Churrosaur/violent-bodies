extends XRController3D

@export var label : Label3D
@export var sword : Sword
@export var explosion : ExplosionFX

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed(name):
	label.text = "button pressed: " + name
	
	if name == "trigger_click":
		label.text = "hooray!"
		sword.toggle()
	
	if name == "ax_button":
		explosion.start_explosion_sequence()


func _on_input_float_changed(name, value):
	label.text = "input float: " + name + ", " + value


func _on_input_vector_2_changed(name, value):
	label.text = "vector changed: " + name + ", " + value
