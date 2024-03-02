
## mech cockpit controls (yoke).
## starts and releases to static.

class_name MyXRGrabbableCockpit
extends MyXRGrabablePickup


func _unstick_from_hand():
	state = STATE.RIGID
	# do not unfreeze
