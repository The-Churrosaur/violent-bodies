extends GPUParticles3D

@export var body : RigidBody3D
@export var min_speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = body.linear_velocity.length_squared()
	if speed < min_speed : emitting = false
	else : emitting = true
