extends XRInputProcessor

@export var gun : StupidGun

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	active = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rhand == null : return
	
	if rhand.get_float("trigger") > 0.2: 
		gun.pull_trigger()
	else : gun.release_trigger()
