extends entity_base
class_name effect_base

@onready var animation_player: AnimationPlayer = $AnimationPlayer
## 開始時のアニメーション名
@export var start_animation_name:String = 'action'

func activate(_data:Dictionary = {}):
	super(_data)
	if _data.has('start_position'):
		global_position = _data.start_position
	if _data.has('direction'):
		rotation = _data.direction.angle()
	animation_player.play(start_animation_name)
	await animation_player.animation_finished
	deactivate()
