
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
	if powered: _power_off()
	else: _power_on()


func _power_on():
	for particle in particles : particle.emitting = true
	powered = true


func _power_off():
	for particle in particles : particle.emitting = false
	powered = false


func _on_area_3d_area_entered(area):
	if area.is_in_group("laser"):
		XRPlayerGlobals.lhand.trigger_haptic_pulse("haptic", 5, 0.4, 0.2, 0)
	else:
		XRPlayerGlobals.lhand.trigger_haptic_pulse("haptic", 5, 10, 0.4, 0)
