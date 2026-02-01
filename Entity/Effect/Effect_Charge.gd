extends GPUParticles2D

@export var actor:actor_base

@export var emit_wait:float = 0.01

var timer:float = 0.0


func _process(_delta: float) -> void:
	timer += _delta
	if timer >= emit_wait:
		timer = 0.0
		global_position = actor.global_position
		emitting = true
