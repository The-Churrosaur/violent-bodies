
## rigidbodies in the hierarchy under other rigidbodies don't work properly. 
## this node reparents its constitutent rigidbodies to the level on ready.
## USE THIS OVER REPARENTING_RIGIDBODY


extends JoltJoint3D

var a : Node
var b : Node


func  _ready():
	#await get_tree().process_frame
	var level = LevelGlobals.level
	if level == null: level = get_tree().root
	
	a = get_node(node_a)
	b = get_node(node_b)
	
	if a is RigidBody3D: a.reparent(level)
	if b is RigidBody3D: b.reparent(level)
	
	node_a = get_path_to(a)
	node_b = get_path_to(b)
