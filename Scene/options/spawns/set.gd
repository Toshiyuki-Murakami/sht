extends spawn_base

func set_start_angle(_data:Dictionary):
	current_angle = 0.0
	finish_angle = 0.0

func spawns(_data:Dictionary):
	set_start_angle(_data)
	var base_angle:float = rand_angle()
	var base_pos:Array = get_spawn_positions(spawn_center_position, spawn_radius, base_angle, finish_angle)
	var sub_radius:float = 32.0
	var outside:bool = false
	## Center Positionが設定されている場合はその場所が中心
	if _data.has('center_position'):
		base_pos = [_data.center_position, Vector2.ZERO]
	## 外側へ向ける設定
	if _data.has('direction_outside'):
		outside = true
	for i in range(_data.count):
		## pos[0]: start_position pos[1]: end_position
		var pos:Array = get_spawn_positions(base_pos[0], sub_radius, current_angle, finish_angle)
		var _actor:enemy_base = Game.poolbase.get_entity(_data.keyname)
		var _delay:float = i * _data.delay if _data.has('delay') else 0.0
		var _dir:Vector2 = Vector2.RIGHT.rotated(current_angle).normalized()
		if outside:
			_dir = (pos[0] - base_pos[0]).normalized()
		if _actor:
			Game.delay(_delay, func():
				_actor.activate({
					'start_position': pos[0],
					'end_position': pos[1],
					'direction': _dir,
					'delay': _delay
				})
			)
		if _data.has('angle'):
			current_angle += _data.angle
			finish_angle -= _data.angle
