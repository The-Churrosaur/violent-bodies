extends Control

@export var target_object : Node
@export var target_property : String

@onready var h_slider = $VBoxContainer/HSlider
@onready var label = $VBoxContainer/Label
@onready var label_2 = $VBoxContainer/Label2


# Called when the node enters the scene tree for the first time.
func _ready():
	label_2.text = target_property
	
	await get_tree().process_frame
	h_slider.value = target_object.get(target_property)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(h_slider.value)


func _on_h_slider_drag_ended(value_changed):
	_set_property(h_slider.value)


func _on_line_edit_text_submitted(new_text):
	var val = float(new_text)
	h_slider.value = val
	_set_property(val)


func _set_property(val):
	if target_object == null or target_property == null: return
	
	target_object.set(target_property, val)
	
	print("property set: ", val)
	print(target_object.get(target_property))
