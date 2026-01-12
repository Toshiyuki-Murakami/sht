extends stage_base
class_name main_stage

@onready var entity: Node2D = $entity
@onready var marker: target_marker = $TargetMarker
@onready var player: Node2D = $entity/Player
@onready var display_border: ReferenceRect = $display_border
@onready var player_border: ReferenceRect = $player_border

func _ready() -> void:
	super()
	Game.entity_node = entity
	Game.marker = marker
	Game.display_border = display_border
	Game.player_border = player_border
	## HP更新
	Signals.change_hp.emit(player.hp, player.max_hp)
