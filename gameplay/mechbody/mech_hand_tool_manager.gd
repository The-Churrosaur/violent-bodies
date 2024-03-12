
class_name MechHandToolManager
extends Node3D

@export var tools : Array[MechTool]
@export var input_grabbable : MyXRGrabbable


var current_tool : MechTool
var current_index = 0


func _ready():
	pass


func set_tool(index):
	print("toolmanager setting tool: ", index)
	if current_tool is MechTool: current_tool.deactivate()
	current_tool = tools[index]
	current_tool.activate(input_grabbable)
	current_index = index


func next_tool():
	print("toolmanager called")
	var next_index = current_index + 1
	if next_index >= tools.size(): next_index = 0
	set_tool(next_index)
