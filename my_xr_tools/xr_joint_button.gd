## button that uses a physics object on a joint for realistic behavior.
## button will fire when 'button' makes physical contact with 'contactbase'.
## button movement is on Y axis.
## inherit this scene to use


class_name XRJointButton
extends Node3D


signal button_pressed()
signal button_released()

signal controller_entered(controller_body : ControllerBody)
signal controller_exited(controller_body : ControllerBody)

@export var contact_base : PhysicsBody3D
@export var button : RigidBody3D

# collection of items currently touching the button
var contact_items = {}

# collection of xrcontroller controllerbodies currently touching the button 
var contact_controller_bodies = {}


func _ready():
	button.body_entered.connect(_on_button_body_entered)
	button.body_exited.connect(_on_button_body_exited)


func _on_button_body_entered(body):
	
	print("button body entered: ", body)
	
	# add body to dict
	contact_items[body] = true
	
	# body is controller
	if body is ControllerBody: _on_controller_body_entered(body)
	
	# button succesfully pressed
	if body == contact_base: _on_button_contacted()


func _on_button_body_exited(body):
	
	# remove body from dict
	contact_items.erase(body)
	
	# body is controller
	if body is ControllerBody: _on_controller_body_exited(body)
	
	# button no longer pressed
	if body == contact_base: _on_button_released()


func _on_button_contacted():
	button_pressed.emit()


func _on_button_released():
	button_released.emit()


func _on_controller_body_entered(controller_body : ControllerBody):
	var controller = controller_body.xr_controller
	contact_controller_bodies[controller_body] = true
	controller_entered.emit(controller_body)


func _on_controller_body_exited(controller_body : ControllerBody):
	var controller = controller_body.xr_controller
	contact_controller_bodies.erase(controller_body)
	controller_exited.emit(controller_body)
