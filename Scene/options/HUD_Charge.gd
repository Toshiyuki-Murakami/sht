extends VBoxContainer

@onready var now_value: Label = $HBox/now
@onready var max_value: Label = $HBox/max

func _ready() -> void:
	Signals.update_chage.connect(_on_update_change)
	hide()

func _on_update_change(_value:float, _max:float):
	if _value < 0.1:
		hide()
	else:
		show()
	now_value.text = '%.1f' % [_value]
	max_value.text = '%.1f' % [_max]
