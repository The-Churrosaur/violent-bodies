
class_name Sword
extends Node3D

@export var particles :Array[GPUParticles3D]

var powered = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func toggle():
	$Label3D.text = "TOGGLING"
	if powered: _power_off()
	else: _power_on()


func _power_on():
	$Label3D.text = "POWERING ON"
	for particle in particles : particle.emitting = true
	powered = true


func _power_off():
	$Label3D.text = "POWERING OFF"
	for particle in particles : particle.emitting = false
	powered = false
