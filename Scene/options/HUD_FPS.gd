extends HBoxContainer

@onready var fps: Label = $fps

func _process(_delta: float) -> void:
	update()


func update():
	fps.text = '%d' % [Engine.get_frames_per_second()]
