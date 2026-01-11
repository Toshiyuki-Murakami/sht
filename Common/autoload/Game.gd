extends Node


## 召喚の中心点
const spawn_radius:float = 512.0
const spawn_center_position:Vector2 = Vector2(500, 500)

## === stage 設定
var stage:Node2D
var entity_node:Node2D
var poolbase:pool_base
var display_border:ReferenceRect

## === 
var marker:target_marker


## ===== 経験値
var xp:int = 0
var next_xp:int = 100

func get_spawn_data():
	pass


## 指定したpositionを中心とした半径の円周上に開始、終了点を取得する
func get_spawn_positions(_center:Vector2 = spawn_center_position, _radius:float = spawn_radius ):
	var start_angle:float = randf_range(0.0, 359.9)
	var start_dir:Vector2 = Vector2(_radius, 0).rotated(deg_to_rad(start_angle))
	var end_angle:float = randf_range(start_angle - 120.0, start_angle + 240.0)
	var end_dir:Vector2 = Vector2(_radius, 0).rotated(deg_to_rad(end_angle))

	return [start_dir + _center, end_dir + _center]
	
func is_active(_node:Variant):
	if !is_instance_valid(_node):
		return false
	if _node is actor_base:
		if _node.state in [actor_base.STATE.POOL, actor_base.STATE.IDLE, actor_base.STATE.CREATE]:
			return false
	
	return true

func stage_add_child(_node):
	entity_node.add_child(_node)

func set_collision(_node:Area2D):
	_node.set_collision_layer(Global.MASK_PLAYER_HITSENDER)
	_node.set_collision_mask(Global.MASK_ENEMY_HITBOX)
	
## 遅延処理
func delay(_time:float, _callable:Callable):
	get_tree().create_timer(_time).timeout.connect(func():
		_callable.call()
	)


func add_xp(_add:int):
	xp += _add
	Signals.add_xp.emit(xp, next_xp)
