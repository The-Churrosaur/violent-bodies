extends Node3D

@export var hand_body : RigidBody3D

@onready var grab_area = $GrabArea
@onready var grab_joint = $GrabJoint

var grabbing = false
var grabbed_object : PhysicsBody3D
var grabbable_body : PhysicsBody3D


func _ready():
	grab_joint.node_a = grab_joint.get_path_to(hand_body)


func _on_grab_area_body_entered(body):
	if (grabbable_body != null) and (body is PhysicsBody3D):
		grabbable_body = body


func _on_grab_area_body_exited(body):
	if body == grabbable_body: 
		grabbable_body = null


## attempts to grab current grabbable object
func try_grab():
	if grabbable_body != null: _grab_object(grabbable_body)


## releases any current grabbed object
func release_grab():
	pass


func _grab_object(body : PhysicsBody3D):
	grabbed_object = body
	grab_joint.node_b = grab_joint.get_path_to(body)
	grab_joint.enabled = true



