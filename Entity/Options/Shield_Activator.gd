extends Area2D

## Trigger Base
@export var trriger:trigger_base
## Just Guardの受付時間
@export var just_time:float = 0.024
## シールド発生エフェクト
@export var shield_main_effect:effect_shield
## シールドヒットエフェクト
@export var shield_hit_effect:effect_shield
## just guard effect name
@export var just_guard_effect_name:String = 'justguard'
## 解除後に再度有効になる時間
@export var next_shield_time:float = 1.0

var shield_activate:bool = false

var entered_actor:Array = []

var actor:actor_base

var restart_timer:float = 0.0

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	trriger.just_change_trigger.connect(_on_just_change_trigger)

func _process(_delta: float) -> void:
	count_up(_delta)
	restart_timer -= _delta 

func _on_area_entered(_area:Area2D):
	if _area is hitsender:
		if _area.actor is bullet_base:
			if shield_activate:
				## シールドが有孔虫の場合はシールド処理
				use_shield(_area.actor)
			else:
				## シールドがない場合はjust回避判定配列に入れる
				entered_actor.append(_area.actor)
				_area.actor.shield_in_time = 0.0
			

func _on_area_exited(_area:Area2D):
	if _area is hitsender:
		entered_actor.erase(_area.actor)

func _on_just_change_trigger(_type:trigger_base.TRIGGER_TYPES, _active:bool):
	if _type == trigger_base.TRIGGER_TYPES.SHIELD:
		if _active:
			if restart_timer <= 0.0:
				on_shield()
				shield_activate = true
				shield_main_effect.activate()
		else:
			shield_activate = false
			shield_main_effect.deactivate()
			restart_timer = next_shield_time
		

## shield内にあるbulletの滞在時間加算
func count_up(_delta:float):
	for _bullet in entered_actor:
		if _bullet is bullet_base:
			if _bullet.active:
				_bullet.shield_in_time += _delta

func on_shield():
	for _bullet in entered_actor:
		if _bullet is bullet_base:
			if _bullet.active:
				prints('[check time]', _bullet.shield_in_time)
				if _bullet.shield_in_time <= just_time:
					prints('[just guard]')
					just_guard(_bullet, _bullet.shield_in_time)

				else:
					## Shield減少
					just_guard(_bullet, _bullet.shield_in_time)
					#use_shield(_bullet)

func use_shield(_bullet:bullet_base):
		## シールド減少エフェクト
		shield_hit_effect.hit()
		## 弾の消去
		_bullet.deactivate()

func just_guard(_bullet:bullet_base, _time:float):
	var _effect:effect_base = Game.poolbase.get_entity(just_guard_effect_name)
	if _effect:
		_effect.activate({
			'start_position': _bullet.global_position,
			'time': _time,
		})
	## 弾の消去
	_bullet.deactivate()
