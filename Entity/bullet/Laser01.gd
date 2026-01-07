extends bullet_base

var shotpoints:shot_points
var point_index:int = 0

func _process(_delta: float) -> void:
	is_life(_delta)
	global_position = shotpoints.get_points(point_index)

func activate(_data:Dictionary = {}):
	super(_data)
	if _data.has('shot_points'):
		shotpoints = _data.shot_points
	if _data.has('point_index'):
		point_index = _data.point_index
	face()
