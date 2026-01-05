extends actor_base

@export var marker:actor_base

func _ready() -> void:
	super()
	global_position = Vector2(200,200)
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
		Signals.hit_player.emit()
	
	return ret
