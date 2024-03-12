extends Node


@export var first_scene : PackedScene


var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
		
		var refresh_rates : Array = xr_interface.get_available_display_refresh_rates()
		refresh_rates.sort()
		var selected_refresh_rate : float
		if refresh_rates.has(90.0):
			selected_refresh_rate = 90.0
		else:
			# Highest possible
			selected_refresh_rate = refresh_rates[refresh_rates.size() - 1]
		
		xr_interface.set_display_refresh_rate(selected_refresh_rate)
		
		Engine.physics_ticks_per_second = int(selected_refresh_rate)
		Engine.max_fps = int(selected_refresh_rate)
		
	else:
		print("OpenXR not initialized, please check if your headset is connected")
		
	
	get_tree().change_scene_to_packed(first_scene)
