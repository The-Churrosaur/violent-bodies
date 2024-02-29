
@tool

extends Node3D


@export var plane : MeshInstance3D
@export var noise_depth = 512

var fnl : FastNoiseLite

func _ready():
	var mat : ShaderMaterial = plane.mesh.surface_get_material(0)
	var noise : NoiseTexture2D = mat.get_shader_parameter("background_noise")
	fnl = noise.noise


func _process(delta):
	_randomize_noise_z_offset()


func _randomize_noise_z_offset():
	fnl.offset.z = randf_range(-noise_depth,noise_depth)
	
