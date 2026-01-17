extends Node2D
class_name pool_base

@export var pool_define:Dictionary = {
	'enemy_cross':{
		'key_name': 'enemy_cross',
		'size': 100,
	},
	'enemy_square128':{
		'key_name': 'enemy_square128',
		'size': 10,
	},
	'enemy_circle01':{
		'key_name': 'enemy_circle01',
		'size': 30,
	},
	'enemy_triangle01':{
		'key_name': 'enemy_triangle01',
		'size': 30,
	},
	'enemy_totu01':{
		'key_name': 'enemy_totu01',
		'size': 30,
	},
	
	'main_bullet': {
		'key_name': 'main_bullet',
		'size': 400,	
	},
	'enemy_bullet': {
		'key_name': 'enemy_bullet',
		'size': 200,
	},
	'enemy_bullet02': {
		'key_name': 'enemy_bullet02',
		'size': 100,
	},
	'laser01': {
		'key_name': 'laser01',
		'size': 20,
	},
	'missile01': {
		'key_name': 'missile01',
		'size': 50,
	},
	'phpton_missile01': {
		'key_name': 'phpton_missile01',
		'size': 50,
	},
	'enemy_laser01': {
		'key_name': 'enemy_laser01',
		'size': 20,
	},
	
	'effect_playerdeath': {
		'key_name': 'effect_playerdeath',
		'size': 1,
	},
	'effect_collision': {
		'key_name': 'effect_collision',
		'size': 50,
	},
	'effect_circle': {
		'key_name': 'effect_circle',
		'size': 100,
	},
	'effect_bullethit': {
		'key_name': 'effect_bullethit',
		'size': 500,
	},
	'justguard': {
		'key_name': 'justguard',
		'size': 5,
	},
	'effect_trail': {
		'key_name': 'effect_trail',
		'size': 50,
	},	
	
	'exp_ball': {
		'key_name': 'exp_ball',
		'size': 1500,
	}
}

var poolnodes:Dictionary = {}

func _ready() -> void:
	Game.poolbase = self
	init_pool()

## 初期プールを作成
func init_pool():
	## パターン分作成
	for _pool_key in pool_define:
		poolnodes[_pool_key] = []
		## 指定サイズ分作成
		for i in range(pool_define[_pool_key].size):
			var _node:entity_base = Scenes.get_duplicate(pool_define[_pool_key].key_name)
			_node.keyname = pool_define[_pool_key].key_name
			_node.poolbase = self
			_node.poolkey = _pool_key
			add_child(_node)
			_node.deactivate()

func in_pool(_node:entity_base):
	poolnodes[_node.poolkey].append(_node)

func out_pool(_node:entity_base):
	poolnodes[_node.poolkey].erase(_node)
	
func get_entity(_poolkey:String):
	if poolnodes[_poolkey].size() > 0:
		return poolnodes[_poolkey].pop_back()
	else:
		print_debug('[no pool]', _poolkey)
		return null
