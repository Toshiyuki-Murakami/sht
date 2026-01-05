extends actor_base
class_name bullet_base

## ベースイメージ
@export var image_base:actor_animation
## ヒット回数
@export var hit_count:int = 1
## 最大射程
@export var max_range:float = 3000.0
## 生存時間
@export var lifetime:float = 8.0
## 進行方向に向ける
@export var to_face:bool = false

var save_hit_count:int = 1
var timer:float = 0.0

func _ready() -> void:
	save_hit_count = hit_count
	set_process(false)
	super()
	activate()

func _process(_delta: float) -> void:
	is_life(_delta)
	face()

func activate(_data:Dictionary = {}):
	super(_data)
	spawn(_data)

func deactivate():
	super()
	state = actor_base.STATE.POOL
	timer = 0.0
	hit_count = save_hit_count

func spawn(_data:Dictionary):

	## dataの設定
	if _data.has('max_range'):
		max_range = _data.max_range
	if _data.has('max_range'):
		max_range = _data.max_range
	if _data.has('lifetime'):
		lifetime = _data.lifetime

	global_position = start_position
	velocity = direction * speed
	state = actor_base.STATE.MOVE

func face():
	if to_face:
		rotation = velocity.angle()


func is_life(_delta:float):
	timer += _delta
	## 生存時間チェック
	if timer >= lifetime:
		deactivate()
	## 距離チェック
	elif global_position.distance_to(start_position) >= max_range:
		deactivate()

## hit count計算および状態返し
func dec_hit_count():
	hit_count -= 1
	return hit_count > 0
