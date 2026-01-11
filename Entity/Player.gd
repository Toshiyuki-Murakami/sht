extends actor_base
class_name player_class

@export var marker:actor_base

func _ready() -> void:
	super()
	state = STATE.MOVE
	## グループ追加
	add_to_group(Global.PLAYER_GROUP)
	## 基本ターゲットをmakerにする
	target_actor = marker
	activate({})

func _process(_delta: float) -> void:
	pass

func receive_hit(_damage:float):
	var ret:bool = super(_damage)
	if ret:
		Signals.hit_player.emit(hp, _damage)
		Signals.change_hp.emit(hp, max_hp)
	
	return ret
