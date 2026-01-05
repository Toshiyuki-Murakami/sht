extends VBoxContainer

@onready var mainbullet_value: Label = $main/mainbullet_value

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	mainbullet_value.text = '%d/%d' % [Game.poolbase.poolnodes.main_bullet.size(), Game.poolbase.pool_define.main_bullet.size]
