extends Node2D
class_name actor_animation

@onready var animation_player: AnimationPlayer = $AnimationPlayer

## 開始アニメーション設定
@export var start_animation:String = 'action'
## イメージ情報
@export var image_base:Sprite2D

## actor
var actor:actor_base

func _ready() -> void:
	if start_animation != '':
		animation_player.play(start_animation)
	

func init_entity():
	animation_player.animation_finished.connect(_on_animation_finish)
	actor.change_state.connect(_on_change_state)
	

func _on_change_state(_state: actor_base.STATE):
	if _state == actor_base.STATE.CREATE:
		animation_player.play('create')
	elif _state == actor_base.STATE.MOVE:
		if start_animation != '':
			animation_player.play(start_animation)	
	elif _state == actor_base.STATE.POOL:
		animation_player.stop()
	
func _on_animation_finish(_action_name:String):
	if _action_name == 'create':
		actor.state = actor.STATE.MOVE
