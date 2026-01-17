extends enemy_base

@onready var label: Label = $Label

func _ready() -> void:
	super()

func _process(_delta: float) -> void:
	label.text = '%d [%d]' % [hp, booking_damage]
