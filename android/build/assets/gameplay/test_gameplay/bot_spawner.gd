extends Node3D

@export var bot_template : PackedScene
@export var bot_target : Node3D




func _on_timer_timeout():
	var bot = bot_template.instantiate()
	bot.player = bot_target
	add_child(bot)
