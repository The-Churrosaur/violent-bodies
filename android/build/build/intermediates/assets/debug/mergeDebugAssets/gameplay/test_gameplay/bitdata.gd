extends Label3D

@export var bit : RagdollBit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(bit.target_node.rotation)
