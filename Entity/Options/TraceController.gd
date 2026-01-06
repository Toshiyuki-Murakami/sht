extends actor_controller_base


func _process(_delta: float) -> void:
	set_player_position()


func set_player_position():
	var old_pos:Vector2 = actor.trace_player.global_position
	var sum_dist:float = 0.0
	for _pos in actor.trace_player.points_log:
		sum_dist += old_pos.distance_to(_pos)
		if sum_dist >= actor.trace_distance:
			actor.global_position = _pos
			break
		else:
			old_pos = _pos
		
