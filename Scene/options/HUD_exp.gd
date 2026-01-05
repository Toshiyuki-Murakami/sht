extends HBoxContainer

@onready var xp: Label = $xp

func _ready() -> void:
	Signals.add_xp.connect(_on_add_xp)

func _on_add_xp(_xp:int, _next_xp:int):
	xp.text = '%d / %d' % [_xp, _next_xp]
