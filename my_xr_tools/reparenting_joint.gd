
## rigidbodies in the hierarchy under other rigidbodies don't work properly. 
## this node reparents its constitutent rigidbodies to the level on ready

extends Joint3D


func  _ready():
	await get_tree().process_frame
	var level = LevelGlobals.level
	level.add_child(get_node(node_a))
	level.add_child(get_node(node_b))
