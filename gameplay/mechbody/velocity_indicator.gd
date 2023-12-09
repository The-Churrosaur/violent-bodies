

class_name VelocityIndicator
extends Node3D


@export var ship : RigidBody3D
@export var mult = 0.02

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
	
	dial.position.z *= -target.length_squared() * mult
