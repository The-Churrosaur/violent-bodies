

class_name VelocityIndicator
extends Node3D


@export var ship : RigidBody3D
@export var mult = 0.002

@onready var dial = $Dial


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	var target = ship.global_position + ship.linear_velocity
	look_at(target)
	
	var speed = ship.linear_velocity.length()
	dial.position.z *= speed * mult
	$speed.text = str(int(speed))
