
class_name TrainingBot
extends RigidBody3D


@export var impulse = 500.0
@export var player : Node3D
@export var slerp_speed = 0.5 # per second

@onready var jitter_timer = $Timer
@onready var shoot_timer = $Timer2
@onready var gun = $lasergun

var r = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	r.seed = name.hash()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	$looker.look_at(player.global_position)
	
	var a = Quaternion(transform.basis)
	var b = Quaternion($looker.transform.basis)
	var c = a.slerp(b, slerp_speed * delta)
	transform.basis = Basis(c)
	


func _on_timer_timeout():
	apply_impulse(Vector3(r.randf(), r.randf(), r.randf()) * impulse)
	jitter_timer.start(1 + r.randf())
	


func _on_shooter_timer_timeout():
	gun.trigger()
	apply_impulse(-transform.basis.z * impulse)
	shoot_timer.start(1 + r.randf())


func _on_area_3d_area_entered(area):
	if area.is_in_group("laser"): explode()


func explode():
	$GPUParticles3D.emitting = true
	freeze = true
	gun.safety = true
	$explosionFX.emitting = true
