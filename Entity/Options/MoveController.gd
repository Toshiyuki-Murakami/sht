extends actor_controller_base
class_name move_controler

## 表示境界線チェックを有効にする
@export var check_display_border:bool = true

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	move(_delta)


func move(_delta:float):
	if !actor:
		return
	if actor.state != actor_base.STATE.MOVE:
		return
	if actor.velocity != Vector2.ZERO:
		actor.translate(actor.velocity * _delta)

	## エリアチェック
	if check_display_border:
		if !Game.display_border.get_rect().has_point(actor.global_position):
			actor.deactivate()
