extends Node3D

var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
		
		xr_interface.set_display_refresh_rate(90.0)
		Engine.physics_ticks_per_second = 90
		Engine.max_fps = 90
		
	else:
		print("OpenXR not initialized, please check if your headset is connected")
