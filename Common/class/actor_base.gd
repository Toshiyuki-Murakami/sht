extends entity_base
class_name actor_base

enum STATE {POOL, IDLE, CREATE, MOVE}

## state変更
signal change_state(_state:STATE)
## Trigger
signal change_trigger(_type:trigger_base.TRIGGER_TYPES, _flg:bool)
## activate
signal change_activate(_data:Dictionary)
## diactivateに変更
signal change_deactivate()
## 自分にエフェクトを追加
signal add_effect(_name:String)

## 移動速度
@export var speed:float = 320.0

## HP
@export var hp:float = 1
## 最大HP
@export var max_hp:int = 1

@export var death_effect:String = 'effect_circle'

var state:STATE = STATE.POOL:
	set(_value):
		if state != _value:
			change_state.emit(_value)
		state = _value

## 向きをホールド
var hold:bool = false

## ターゲット情報
var target_actor:actor_base
## ポイント履歴
var points_log:Array = []

func _ready() -> void:
	base_name = 'actor'
	add_effect.connect(_on_add_effect)
	super()

func _on_add_effect(_name:String):
	effect(_name)


func calc_hp(_value:float):
	hp -= _value
	return hp > 0.0
		
func activate(_data:Dictionary = {}):
	super(_data)
	change_activate.emit(_data)
	
func deactivate():
	super()
	target_actor = null
	change_deactivate.emit()

func receive_hit(_damage:float):
	var ret:bool = calc_hp(_damage)
	if !ret:
		deactivate()
		effect(death_effect)
		return false

	return true

func effect(_effect_name:String):
	## ここが将来的にPOOLから取得する
	var _effect:effect_base = Game.poolbase.get_entity(_effect_name)
	if _effect:
		_effect.activate({
			'start_position': global_position,
		})
