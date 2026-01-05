extends stage_base
class_name main_stage

@onready var entity: Node2D = $entity
@onready var marker: target_marker = $TargetMarker
@onready var player: Node2D = $entity/Player

func _ready() -> void:
	super()
	Game.entity_node = entity
	Game.marker = marker

	## HP更新
	Signals.change_hp.emit(player.hp, player.max_hp)
