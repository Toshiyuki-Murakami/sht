extends actor_base
class_name enemy_base


## HPを保持
var save_hp:float = 1

func _ready() -> void:
	super()
	save_hp = hp
	

func activate(_data:Dictionary = {}):
	super(_data)
	hp = save_hp
	state = STATE.CREATE
	velocity = direction * speed
	add_to_group(Global.ENEMY_GROUP)


func deactivate():
	super()
	remove_from_group(Global.ENEMY_GROUP)
	## 移動停止
	velocity = Vector2.ZERO
	if hp == 0:
		Signals.kill_enemy.emit(keyname)

	
