extends HBoxContainer

@onready var hp: Label = $hp

func _ready() -> void:
	Signals.change_hp.connect(_on_change_hp)

func _on_change_hp(_hp:int, _max_hp:int):
	hp.text = '%d / %d' % [_hp, _max_hp]
