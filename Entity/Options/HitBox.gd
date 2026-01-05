extends Area2D
class_name hitbox

@export var death_effect:String = 'effect_circle'

var actor:actor_base

var ref_image:Sprite2D
var collshape:CollisionShape2D
var collpoly:CollisionPolygon2D

func _ready():
	ref_image = get_parent().image_base
	for child in get_children():
		if child is CollisionShape2D:
			collshape = child
		if child is CollisionPolygon2D:
			collpoly = child


func _on_change_activate(_data:Dictionary):
	#collshape.disabled = false
	pass

func _on_change_deactivate():
	if collshape:
		collshape.set_deferred('disabled', true)
	if collpoly:
		collpoly.set_deferred('disabled', true)

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


func receive_hit(_damage:float):
	return actor.receive_hit(_damage)


func effect():
	## ここが将来的にPOOLから取得する
	var _effect:effect_base = Game.poolbase.get_entity(death_effect)
	if _effect:
		_effect.activate({
			'start_position': global_position,
			'modulate': ref_image.modulate
		})
