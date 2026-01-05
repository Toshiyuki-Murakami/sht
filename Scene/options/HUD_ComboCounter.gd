extends Control

@onready var combo_label: Label = $ComboLine/combo_label

## Combo Reset Time
@export var reset_time:float = 3.0

var old_key:String = ''
var combo_count:int = 0

var timer:float = 0.0

func _ready() -> void:
	Signals.kill_enemy.connect(_on_kill_enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if timer > 0.0:
		timer = timer - _delta if timer > _delta else 0.0
		if timer == 0.0:
			combo_count = 1
			update_label()
	

func _on_kill_enemy(_keyname:String):
	if _keyname == old_key:
		combo_count += 1
	else:
		old_key = _keyname
		combo_count = 1
	timer = reset_time
	update_label()

func update_label():
	combo_label.text = 'x%d' % combo_count
