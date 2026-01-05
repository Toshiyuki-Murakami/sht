extends entity_base
class_name effect_death

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	pass # Replace with function body.


func activate(_data:Dictionary = {}):
	super(_data)
	gpu_particles_2d.emitting = true
	await gpu_particles_2d.finished
	deactivate()
