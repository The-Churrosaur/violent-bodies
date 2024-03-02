
## my_xr_grabbable as physics object.
## on pickup, freezes and lerps to align my hold_reference with hand's hold_reference.
## once lerp is complete, follows 

class_name MyXRGrabablePickup
extends MyXRGrabbable

## must be a direct child
@export var hold_reference : Node3D
@export var lerp_weight = 0.5

# state flags
enum STATE {RIGID, LERPING, FOLLOWING}
var state : STATE = STATE.RIGID


func _physics_process(delta):
	
	match state:
	
		STATE.LERPING: 
			
			# lerp self to hand ref + inverse of hold_reference
			# (offsets pos from hand ref by distance to hold_ref)
			var hold_inv = hold_reference.transform.affine_inverse()
			
			# composes transforms 
			var target_transform = \
				hand_grabber.hold_reference.global_transform * hold_inv
			
			global_transform = \
			global_transform.interpolate_with(target_transform, lerp_weight)
			
			# target met, change state
			if hold_reference.global_transform == target_transform: 
				_stick_to_hand()
				state = STATE.FOLLOWING
		
		STATE.FOLLOWING:
			
			# follow reference exactly
			var hold_inv = hold_reference.transform.affine_inverse()
			
			var target_transform = \
				hand_grabber.hold_reference.global_transform + hold_inv
			
			global_transform = target_transform
			
		
		STATE.RIGID:
			pass



# PRIVATE ----------------------------------------------------------------------



# when grabbed, freeze, start lerping
func _grab(grabber):
	super(grabber)
	freeze = true
	state = STATE.LERPING


func _drop(grabber):
	super(grabber)
	_unstick_from_hand()


func _stick_to_hand():
	state = STATE.FOLLOWING


# when dropped, unfreeze
func _unstick_from_hand():
	state = STATE.RIGID
	freeze = false

