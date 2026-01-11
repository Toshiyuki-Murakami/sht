extends Node2D


@export var level:int = 0

@export var spawn_span:float = 2.0

var stage:stage_base

var spawn_func:Dictionary = {}

## Timer
var timer:float = 0.0

func _ready() -> void:
	## functions設定
	for _node in get_children():
		if _node is spawn_base:
			spawn_func[_node.spawn_name] = _node

	Signals.set_spawn.connect(_on_set_spawn)


func _process(_delta: float) -> void:
	timer += _delta
	if spawn_span <= timer:
		reset_timer()
		var dat:Dictionary = Datas.spawns[0][3]
		spawn(dat)
	
func _on_set_spawn(_data:Dictionary):
	spawn(_data)

func spawn(_data:Dictionary):
	if spawn_func.has(_data.type):
		spawn_func[_data.type].spawns(_data)
	


func reset_timer():
	timer = 0.0
