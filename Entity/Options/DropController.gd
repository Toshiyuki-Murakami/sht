extends actor_controller_base

## dropするxp
@export var exp_count:int = 5

## deactive時
func _on_change_deactivate():
	## 破壊時
	if actor.hp == 0:
		drop_xp()
	super()

func drop_xp():
	for i in range(exp_count):
		var _ball:exp_ball = Game.poolbase.get_entity('exp_ball')
		if _ball:
			_ball.activate({
				'start_position': actor.global_position,
			})
