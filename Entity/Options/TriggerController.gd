extends trigger_base

@onready var label: Label = $Label

func _on_change_trigger(_type:TRIGGER_TYPES, _flg:bool):
	super(_type, _flg)
	label.text = '%s' % _flg
