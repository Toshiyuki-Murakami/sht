extends Node2D
class_name spawn_base

## spawn名称
@export var spawn_name:String = 'normal'
## 
@export var fisnish_range_angle:float = 60.0
## 召喚の中心点
@export var spawn_radius:float = 512.0
@export var spawn_center_position:Vector2 = Vector2(500, 500)

var current_angle:float = 0.0
var finish_angle:float = 0.0

func set_start_angle(_data:Dictionary):
	current_angle = rand_angle()
	finish_angle = rand_angle(current_angle, fisnish_range_angle)

func spawns(_data:Dictionary):
	set_start_angle(_data)
	for i in range(_data.count):
		## pos[0]: start_position pos[1]: end_position
		var pos:Array = get_spawn_positions(spawn_center_position, spawn_radius, current_angle, finish_angle)
		var _actor:enemy_base = Game.poolbase.get_entity(_data.keyname)
		var _delay:float = i * _data.delay if _data.has('delay') else 0.0
		if _actor:
			Game.delay(_delay, func():
				_actor.activate({
					'start_position': pos[0],
					'end_position': pos[1],
					'direction': Vector2(pos[1] - pos[0]).normalized(),
					'delay': _delay
				})
			)
		if _data.has('angle'):
			current_angle += _data.angle
			finish_angle -= _data.angle


func rand_angle(_base:float = 0.0, _added:float = 0.0):
	if _added == 0.0:
		return randf_range(0.0, 359.9)
	else:
		return randf_range(_base - (180.0 - _added), _base + 180 + _added)

## 指定したpositionを中心とした半径の円周上に開始、終了点を取得する
func get_spawn_positions(_center:Vector2 = spawn_center_position, _radius:float = spawn_radius, _start_angle:float = 999.99, _end_angle:float = 999.99):
	var start_angle:float = _start_angle if _start_angle != 999.99 else rand_angle()
	var end_angle:float = _end_angle if _end_angle != 999.99 else rand_angle(start_angle, 120.0)
	var start_dir:Vector2 = Vector2(_radius, 0).rotated(deg_to_rad(start_angle))
	var end_dir:Vector2 = Vector2(_radius, 0).rotated(deg_to_rad(end_angle))

	return [start_dir + _center, end_dir + _center]
