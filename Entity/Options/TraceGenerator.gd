extends actor_controller_base
class_name trace_generator

## Log保持数
@export var log_count:int = 60

func _process(_delta: float) -> void:
	point_logging()

func _on_change_deactivate():
	super()
	## point履歴の初期化
	actor.points_log = []

func point_logging():
	if actor.velocity != Vector2.ZERO:
		##log追加
		actor.points_log.push_front(actor.global_position)
		## 保持数オーバーは捨てていく
		if actor.points_log.size() > log_count:
			actor.points_log.pop_back()
