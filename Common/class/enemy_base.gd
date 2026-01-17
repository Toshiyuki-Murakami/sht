extends actor_base
class_name enemy_base




func _ready() -> void:
	super()
	

func activate(_data:Dictionary = {}):
	super(_data)
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

	
