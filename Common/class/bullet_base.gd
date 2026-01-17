extends actor_base
class_name bullet_base

## ベースイメージ
@export var image_base:actor_animation
## ダメージ
@export var damage:float = 1.0
## ヒット回数
@export var hit_count:int = 1
## ロックオン重複チェック
@export var check_booking:bool = false
## 最大射程
@export var max_range:float = 3000.0
## 生存時間
@export var lifetime:float = 8.0
## 進行方向に向ける
@export var to_face:bool = false

## 所有者
var owner_actor:actor_base

var save_hit_count:int = 1
var timer:float = 0.0
## shield範囲接触時間
var shield_in_time:float = 0.0

func _ready() -> void:
	save_hit_count = hit_count
	set_process(false)
	super()
	#activate()

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
	if _data.has('owner_actor'):
		owner_actor = _data.owner_actor

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
