extends Area2D
class_name hitbodysender

## ダメージ
@export var damage:float = 1.0
## 継続ダメージ有効
@export var is_continuous:bool = true
## 継続ダメージ間隔
@export var continuous_time:float = 0.5
## hit時のエフェクト
@export var effect_hit:String = 'effect_collision'

var actor:actor_base
var collshape:CollisionShape2D
var collpoly:CollisionPolygon2D

var timer:float = 0.0
var hit_targets:Array = []

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	for child in get_children():
		if child is CollisionShape2D:
			collshape = child
		if child is CollisionPolygon2D:
			collpoly = child

func _process(_delta: float) -> void:
	timer += _delta
	if timer >= continuous_time:
		timer = 0.0
		for _node in hit_targets:
			if _node.receive_hit(damage):
				prints('[prcess]', _node.global_position)
				#effect(_node.global_position)
				_node.add_effect.emit(effect_hit)

func _on_area_entered(_area:Area2D):
	if _area is hitbox:
		if _area.actor.receive_hit(damage):
			_area.actor.add_effect.emit(effect_hit)
			#effect(_area.actor.global_position)
		
		hit_targets.append(_area.actor)
		if is_continuous:
			set_process(true)


func _on_area_exited(_area:Area2D):
	hit_targets.erase(_area.actor)
	if hit_targets.size() == 0:
		set_process(false)

func _on_change_activate(_data:Dictionary):
	if collshape:
		collshape.set_deferred('disabled', false)
	if collpoly:
		collpoly.set_deferred('disabled', false)

func _on_change_deactivate():
	if collshape:
		collshape.set_deferred('disabled', true)
	if collpoly:
		collpoly.set_deferred('disabled', true)
	set_process(false)
	hit_targets = []

func _on_change_state(_state:actor_base.STATE):
	if _state == actor_base.STATE.MOVE:
		if collshape:
			collshape.disabled = false
		if collpoly:
			collpoly.disabled = false



func init_entity():
	actor.change_activate.connect(_on_change_activate)
	actor.change_deactivate.connect(_on_change_deactivate)
	actor.change_state.connect(_on_change_state)


func effect(_pos:Vector2):
	## ここが将来的にPOOLから取得する
	var _effect:effect_base = Game.poolbase.get_entity(effect_hit)
	if _effect:
		_effect.activate({
			'start_position': _pos,
		})	
