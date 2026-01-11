extends effect_base

@onready var time: Label = $time

func activate(_data:Dictionary = {}):
	if _data.has('time'):
		time.text = '%.3f' % [_data.time]
	super(_data)
