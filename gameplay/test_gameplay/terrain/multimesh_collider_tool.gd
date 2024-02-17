@tool

extends MultiMeshInstance3D

@export var body : PhysicsBody3D
@export var collider : CollisionShape3D
@export var run = false

func _process(delta):
	
	if !Engine.is_editor_hint(): return
	
	if run:
		run = false
		_add_shapes()

func _add_shapes():
	print("ADDING COLLIDERS TO MULTIMESH...")
	print(multimesh.instance_count)
	for i in multimesh.instance_count:
		var transform = multimesh.get_instance_transform(i)
		var copy = collider.duplicate()
		body.add_child(copy)
		copy.owner = get_tree().edited_scene_root
		copy.transform = transform


