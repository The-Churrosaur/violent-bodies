extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()


func _on_area_3d_area_entered(area):
	if area.is_in_group("laser"):
		linear_velocity = -linear_velocity
		position += linear_velocity * 0.01
