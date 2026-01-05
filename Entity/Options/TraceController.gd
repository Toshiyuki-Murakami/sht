extends actor_controller_base


func _process(_delta: float) -> void:
	set_player_position()


func set_player_position():
	if actor.trace_player.points_log.size() >= 20:
		actor.global_position = actor.trace_player.points_log[19]
		
