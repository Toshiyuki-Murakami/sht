extends actor_controller_base
class_name shot_points

@onready var points_list: Node2D = $points_list

## 中心からの距離
@export var start_range:float = 20.0
## 発射箇所数
@export var multi:int = 1

@export var multi_span:float = 12

@export var to_target_face:bool = false

var points:Array = []

func _ready() -> void:
	## 中心点からの距離設定
	points_list.position.x = start_range
	##　リスト作成
	var i:int = 0
	for _node in points_list.get_children():
		_node.position.y = i * multi_span
		points.append(_node)
		i += 1
	set_multi(multi, multi_span)

func _process(_delta: float) -> void:
	if to_target_face:
		if actor.target_actor:
			if !actor.hold:
				rotation = (actor.target_actor.global_position - actor.global_position).angle()

func set_multi(_value:int, _span:float):
	multi = _value
	multi_span = _span
	set_multi_span()

	if multi % 2 == 0:
		points_list.position.y = -(((float(multi) / 2) - 1) * multi_span + multi_span / 2)
	else:
		points_list.position.y = -(floor(float(multi) / 2) * multi_span)	

	for i in range(points.size()):
		points[i].visible = i < multi

func set_multi_span(): 
	for i in points.size():
		points[i].position.y = i * multi_span


func get_points(_idx:int):
	return points[_idx].global_position
