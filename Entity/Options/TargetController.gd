extends actor_controller_base

@onready var in_range: Area2D = $inRange
@onready var collision_shape_2d: CollisionShape2D = $inRange/CollisionShape2D

@export var attack_range:float = 300.0

var targets:Array = []

func _ready() -> void:
	in_range.area_entered.connect(_on_area_entered)
	in_range.area_exited.connect(_on_area_exited)
	change_range(attack_range)
	

func _process(_delta: float) -> void:
	check_range()

func _on_area_entered(_area:Area2D):
	if _area.actor is enemy_base:
		targets.append(_area.actor)

func _on_area_exited(_area:Area2D):
	targets.erase(_area.actor)

func _on_change_activate(_data:Dictionary = {}):
	super(_data)

func _on_change_deactivate():
	super()
	targets = []


func change_range(_attack_range:float):
	(collision_shape_2d.shape as CircleShape2D).radius = _attack_range

func check_range():
	var distance:float = 9999.9
	var _target:enemy_base = null
	for _enemy in targets:
		var _d:float = actor.global_position.distance_to(_enemy.global_position)
		if _d < distance:
			_target = _enemy
			distance = _d
	
	actor.target_actor = _target
	actor.change_trigger.emit(trigger_base.TRIGGER_TYPES.FIRE, _target != null)
