
class_name Sword
extends MechTool

@export var particles :Array[GPUParticles3D]

var powered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func trigger():
	super.trigger()
	toggle()



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
