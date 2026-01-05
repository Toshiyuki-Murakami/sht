extends stage_base
class_name main_stage

@onready var entity: Node2D = $entity
@onready var marker: target_marker = $TargetMarker

func _ready() -> void:
	super()
	Game.entity_node = entity
	Game.marker = marker
