extends spawn_base

func set_start_angle(_data:Dictionary):
	current_angle = 0.0
	finish_angle = 0.0

func spawns(_data:Dictionary):
	set_start_angle(_data)
	var base_angle:float = rand_angle()
	var base_pos:Array = get_spawn_positions(spawn_center_position, spawn_radius, base_angle, finish_angle)
	## Center Positionが設定されている場合はその場所が中心
	if _data.has('center_position'):
		base_pos = [_data.center_position, Vector2.ZERO]
	## Player座標を取得
	var nodes_in_group = get_tree().get_nodes_in_group(Global.PLAYER_GROUP)
	var player_pos:Vector2 = nodes_in_group[0].global_position if nodes_in_group.size() > 0 else Vector2.ZERO
	var _base_direction:Vector2 = player_pos - base_pos[0]
	var _base_angle:float = rad_to_deg(_base_direction.angle())
	for i in range(_data.count):
		var _spit_angle:float = rand_angle(-_base_angle, _data.angle)
		## pos[0]: start_position pos[1]: end_position
		var _actor:enemy_base = Game.poolbase.get_entity(_data.keyname)
		var _delay:float = i * _data.delay if _data.has('delay') else 0.0
		var _dir:Vector2 = Vector2.RIGHT.rotated(_spit_angle).normalized()
		if _actor:
			Game.delay(_delay, func():
				_actor.activate({
					'start_position': base_pos[0],
					'end_position': player_pos,
					'direction': _dir,
					'delay': _delay
				})
			)
