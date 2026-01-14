extends bullet_base

@onready var collision_shape_2d: CollisionShape2D = $HitSender/CollisionShape2D

## 命中判定までの時間
@export var wait_time:float = 1.5

var shotpoints:shot_points
var point_index:int = 0

var collision_timer:float = 0.0

func _process(_delta: float) -> void:
	if !owner_actor.active:
		deactivate()
		return
	is_life(_delta)
	global_position = shotpoints.get_points(point_index)
	## 予告線分待つ
	collision_timer += _delta
	if collision_timer >= wait_time:
		collision_shape_2d.disabled = false


func activate(_data:Dictionary = {}):
	collision_shape_2d.disabled = true
	super(_data)
	if _data.has('shot_points'):
		shotpoints = _data.shot_points
	if _data.has('point_index'):
		point_index = _data.point_index
	face()

func deactivate():
	super()
	collision_shape_2d.disabled = true
	collision_timer = 0.0
