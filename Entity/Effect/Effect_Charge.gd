extends GPUParticles2D

@export var actor:actor_base




func _process(_delta: float) -> void:
	global_position = actor.global_position
