extends Area2D
class_name hitsender

## Hit Effect
@export var hit_effect:String = 'effect_bullethit'
## ダメージ
@export var damage:float = 1.0
## 継続ダメージ有効
@export var is_continuous:bool = false
## 継続ダメージ間隔
@export var continuous_time:float = 0.0
## 予告時間
@export var notice_time:float = 0.0

var actor:bullet_base
var collshape:CollisionShape2D
var ref_image:actor_animation

var timer:float = 0.0
var hit_targets:Array = []

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	for child in get_children():
		if child is CollisionShape2D:
			collshape = child

func _process(_delta: float) -> void:
	timer += _delta
	if timer >= continuous_time:
		timer = 0.0
		for _node in hit_targets:
			_node.receive_hit(damage)

func _on_area_entered(_area:Area2D):
	if _area is hitbox:
		if _area.receive_hit(damage):
			effect()
		## hitcount減算
		if actor.dec_hit_count():
			## 残りがあればtargesを追加して続行
			hit_targets.append(_area)
			if is_continuous:
				set_process(true)
		else:
			## なければ無効化
			actor.deactivate()

func _on_area_exited(_area:Area2D):
	hit_targets.erase(_area)
	if hit_targets.size() == 0:
		set_process(false)

func _on_change_activate(_data:Dictionary):
	damage = actor.damage
	pass

func _on_change_deactivate():
	collshape.set_deferred('disabled', true)

func _on_change_state(_state:actor_base.STATE):
	if _state == actor_base.STATE.MOVE:
		if notice_time == 0.0:
			collshape.disabled = false

func init_entity():
	actor.change_activate.connect(_on_change_activate)
	actor.change_deactivate.connect(_on_change_deactivate)
	actor.change_state.connect(_on_change_state)
	ref_image = actor.image_base

func effect():
	## ここが将来的にPOOLから取得する
	var _effect:effect_base = Game.poolbase.get_entity(hit_effect)
	if _effect:
		_effect.activate({
			'start_position': global_position,
			'direction': actor.velocity,
			'modulate': ref_image.modulate
		})	
