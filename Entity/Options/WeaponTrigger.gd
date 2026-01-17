extends Node2D
class_name weapon_trigger

## 発射位置情報
@export var shotpoints:shot_points
## 発射対象
@export var bullet_name:String = 'main_bullet'
## Cooltime
@export var cooltime:float = 1.0
## Burst Mode設定
@export var use_burst:bool = false
## マルチショット数
@export var multi:int = 1
## マルチショットの間隔
@export var multi_span:float = 8.0
## マルチショットの角度
@export var multi_angle_deg:float = 5.0
## 射撃後cooltimeまでホールド
@export var shot_after_hold:bool = false

var actor:actor_base

var save_cooltime:float = 0.0
var save_multi:int = 1

var timer:float = 0.0


func _ready() -> void:
	reset_timer()
	## Burst Modeが有効なら設定
	if use_burst:
		Signals.set_burst.connect(_on_set_burst)

func _process(_delta: float) -> void:
	if timer > 0.0:
		timer -= _delta
		if timer <= 0.0:
			if shot_after_hold:
				actor.hold = false

## burstモード処理
func _on_set_burst(_flg:bool):
	if _flg:
		save_cooltime = cooltime
		save_multi = multi
		cooltime = cooltime / 4
		multi = multi * 2
	else:
		cooltime = save_cooltime
		multi = save_multi

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
	var _dir:Vector2 = (actor.target_actor.global_position - actor.global_position).normalized()
	for i in multi:
		## ここが将来的にPOOLから取得する
		var _bullet:bullet_base = Game.poolbase.get_entity(bullet_name)
		if _bullet:
			_bullet.activate({
				'start_position': shotpoints.get_points(i),
				'direction': get_direction(shotpoints.get_points(i), actor.global_position),
				'owner_actor': actor,
				'shot_points': shotpoints,
				'point_index': i,
			})
			## タイマーリセット
		if shot_after_hold:
			actor.hold = true
		reset_timer()

func get_direction(_from:Vector2, _to:Vector2):
	return Vector2(_from - _to).normalized()


func calc_direction(_idx:int, _dir:Vector2):
	var center:float = float(multi) / 2 - 0.5
	var add:float = (float(_idx) - center) * deg_to_rad(multi_angle_deg)
	return Vector2(1,0).rotated(_dir.angle() + add)
	
