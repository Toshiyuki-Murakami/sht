extends Node2D
class_name weapon_trigger

## 発射位置情報
@export var shotpoints:shot_points
## 発射対象
@export var bullet_name:String = 'main_bullet'
## Cooltime
@export var cooltime:float = 1.0

## マルチショット数
@export var multi:int = 1
## マルチショットの間隔
@export var multi_span:float = 8.0
## マルチショットの角度
@export var multi_angle_deg:float = 5.0
## 射撃後cooltimeまでホールド
@export var shot_after_hold:bool = false

var actor:actor_base

var timer:float = 0.0

func _ready() -> void:
	reset_timer()

func _process(_delta: float) -> void:
	if timer > 0.0:
		timer -= _delta
		if timer <= 0.0:
			if shot_after_hold:
				actor.hold = false
		

func reset_timer():
	timer = cooltime


func trigger():
	if !actor.visible:
		return
	## cooltimeが終わっていなければ動作しない
	if timer > 0.0:
		return
	if !Game.is_active(actor.target_actor):
		return
	shotpoints.set_multi(multi, multi_span)
	var dir:Vector2 = (actor.target_actor.global_position - actor.global_position).normalized()
	for i in multi:
		## ここが将来的にPOOLから取得する
		var _bullet:bullet_base = Game.poolbase.get_entity(bullet_name)
		if _bullet:
			_bullet.activate({
				'start_position': shotpoints.get_points(i),
				'direction': calc_direction(i, dir),
				'owner_actor': actor,
				'shot_points': shotpoints,
				'point_index': i,
			})
			## タイマーリセット
		if shot_after_hold:
			actor.hold = true
		reset_timer()

func calc_direction(_idx:int, _dir:Vector2):
	var center:float = float(multi) / 2 - 0.5
	var add:float = (float(_idx) - center) * deg_to_rad(multi_angle_deg)
	return Vector2(1,0).rotated(_dir.angle() + add)
	
