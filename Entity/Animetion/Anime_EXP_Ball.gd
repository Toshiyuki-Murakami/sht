extends actor_animation

## 登場時のスピード
var creat_move_speed:Vector2 = Vector2.ZERO
## 定位置に行くまでの時間
var create_playtime:float = 0.0

func init_entity():
	super()
	create_playtime = animation_player.get_animation('create').length

func _process(_delta: float) -> void:
	if creat_move_speed != Vector2.ZERO:
		image_base.translate(creat_move_speed * _delta)

func _on_change_state(_state: actor_base.STATE):
	## 初回のポイント位置をずらしておく
	if _state == actor_base.STATE.CREATE:
		creat_move_speed = (Vector2(0, 0) - image_base.position) / create_playtime
	super(_state)

func _on_animation_finish(_action_name:String):
	super(_action_name)
	if _action_name == 'create':
		creat_move_speed = Vector2.ZERO
