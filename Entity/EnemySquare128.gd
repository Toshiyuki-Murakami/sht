extends enemy_base


func _ready() -> void:
	super()

func deactivate():
	super()
	if hp == 0:
		## spawn設定
		Signals.set_spawn.emit({
			'keyname': 'enemy_triangle01',
			'type': 'set',
			'count': 4,
			'angle': 90.0,
			'target_player': true,
			'center_position': global_position,
			'direction_outside': true
		})
