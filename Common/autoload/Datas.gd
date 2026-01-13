extends Node

## 出現パターン
enum SPAWN_TYPE {DEFAULT, CIRCLE}

var spawns:Array = [
	## グループパターンごとにわける
	[
		{
			'keyname': 'enemy_totu01',
			'type': 'normal',
			'count': 3,
			'angle': 15.0,
			'delay': 0.1,
		},
		{
			'keyname': 'enemy_cross',
			'type': 'spit',
			'count': 30,
			'angle': 45.0,
			'delay': 0.025,
		},
		{
			'keyname': 'enemy_triangle01',
			'type': 'set',
			'count': 4,
			'angle': 90.0,
			'target_player': true,
			'center_position': Vector2.ZERO
		},
		{
			'keyname': 'enemy_square128',
			'type': 'normal',
			'count': 1,
		},
		{
			'keyname': 'enemy_circle01',
			'type': 'normal',
			'count': 5,
			'angle': 8.0,
			'delay': 0.1,
		},
	]
]
