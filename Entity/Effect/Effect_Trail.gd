extends entity_base
class_name effect_trail

@onready var line_2d: Line2D = $Line2D

@export var max_points:int = 24
@export var record_interval:float = 0.02

@export var entity: actor_base

var _points: Array[Vector2] = []
var _timer:float = 0.0
var target_active:bool = true

func _process(_delta:float):
	if !entity.active:
		target_active = false
	_timer += _delta
	if _timer >= record_interval:
		_timer = 0.0
		if target_active:
			_points.push_front(entity.global_position)
			if _points.size() > max_points:
				_points.pop_back()
		else:
			_points.pop_back()

		line_2d.points = _points
		if _points.size() == 0:
			deactivate()
			return

func activate(_data:Dictionary = {}):
	super(_data)
	if _data.has('owner_actor'):
		entity = _data.owner_actor
	if _data.has('modulate'):
		line_2d.modulate = _data.modulate
	_timer = 0.0
	_points = []
	target_active = true
	
