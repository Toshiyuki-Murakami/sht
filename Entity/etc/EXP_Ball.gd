extends actor_base
class_name exp_ball

## 1庫あたりの経験値数
@export var xp:int = 1

@export var min_set_radius:float = 32.0
@export var max_set_radius:float = 64.0
## animationを指定
@export var anime:actor_animation



func activate(_data:Dictionary = {}):
	super(_data)
	spawn_phase(_data)
	state = STATE.CREATE

func deactivate():
	if state == STATE.MOVE:
		## 経験値加算
		Game.add_xp(xp)
	super()


func spawn_phase(_data:Dictionary):
	var _radius:float = randf_range(min_set_radius, max_set_radius)
	var _pos:Array = Game.get_spawn_positions(_data.start_position, _radius)
	## imageの開始位置をstart_positionにする
	anime.image_base.position = _data.start_position - _pos[0]
	## end_pointに予め移動させておく
	global_position = _pos[0]
