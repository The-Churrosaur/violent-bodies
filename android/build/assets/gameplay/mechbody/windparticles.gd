extends GPUParticles3D

@export var body : RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = body.linear_velocity.length_squared()
	if speed < 5 : emitting = false
	else : emitting = true
	process_material.initial_velocity_min = speed
	process_material.initial_velocity_max = speed
