extends chase_controller

## exp取得距離
@export var player_get_distance:float = 8.0

## ターゲットがあれば追跡する設定
func check_target():
	if is_chase:
		return true
	if is_instance_valid(actor.target_actor):
		actor.velocity = (actor.target_actor.global_position - actor.global_position).normalized() * actor.speed
		is_chase = true
	return is_chase

## ホーミング中に一定距離に入れば
func homing(_delta:float):
	if super(_delta):
		## 一定距離になったら無効化
		if actor.global_position.distance_to(actor.target_actor.global_position) <= player_get_distance:
			actor.deactivate()
