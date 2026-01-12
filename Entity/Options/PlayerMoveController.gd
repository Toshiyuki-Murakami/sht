extends move_controler

@onready var label: Label = $Label

## 範囲外ダメージ間隔
@export var out_of_area_damage_span:float = 0.2
## 範囲ダメージ
@export var damage:int = 1
## ダメージエフェクト
@export var hit_effect:String = 'effect_collision'

## 範囲外フラグ
var out_of_area:bool = false

var timer:float = 0.0

func _process(_delta: float) -> void:
	super(_delta)
	if out_of_area:
		timer += _delta
		if timer >= out_of_area_damage_span:
			area_damage()
			timer = 0.0
	else:
		timer = 0.0


func move(_delta:float):
	super(_delta)
	## 範囲外チェック
	out_of_area = !Game.player_border.get_rect().has_point(actor.global_position)
	label.text = '%s' % out_of_area

func area_damage():
	if actor.receive_hit(damage):
		effect()

func effect():
	## ここが将来的にPOOLから取得する
	var _effect:effect_base = Game.poolbase.get_entity(hit_effect)
	if _effect:
		_effect.activate({
			'start_position': actor.global_position,
			'direction': actor.velocity,
		})	
