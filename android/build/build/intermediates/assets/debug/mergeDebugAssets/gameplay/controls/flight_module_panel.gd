extends Label3D

@export var flight_module : FlightModule

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flight_module == null : return
	$Label3D.text = flight_module.data
	$ENABLED.visible = flight_module.enabled
