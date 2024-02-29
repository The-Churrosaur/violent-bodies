extends RigidBody3D


func _input(event):
	if event.is_action_pressed("ui_right"): apply_central_force(Vector3(10,0,0))
	if event.is_action_pressed("ui_left"): apply_central_force(Vector3(-10,0,0))
	if event.is_action_pressed("ui_up"): apply_central_force(Vector3(0,10,0))
	if event.is_action_pressed("ui_down"): apply_central_force(Vector3(0,-10,0))
