extends InputManager

@export var cockpit : Node3D
@export var move_scale = 0.1 #m/s

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	
	if !active : return
	
	var axis = controller.get_vector2("primary")
	
	cockpit.position += cockpit.transform.basis.z * axis.x * delta * move_scale
	cockpit.position += cockpit.transform.basis.y * axis.y * delta * move_scale

func _on_controller_button_pressed(str : String):
	super._on_controller_button_pressed(str)
	
	
