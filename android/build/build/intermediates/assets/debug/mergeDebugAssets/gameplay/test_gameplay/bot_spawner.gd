extends Node3D

@export var bot_template : PackedScene
@export var bot_target : Node3D
@export var enabled = true




func _on_timer_timeout():
	if !enabled : return
	var bot = bot_template.instantiate()
	bot.player = bot_target
	add_child(bot)
