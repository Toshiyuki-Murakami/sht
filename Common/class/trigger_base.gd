extends actor_controller_base
class_name trigger_base

enum TRIGGER_TYPES {NON, FIRE}

## fire trigger
var fire_trigger:bool = false


func _ready() -> void:
	pass # Replace with function body.

func init_entity():
	super()
	actor.change_trigger.connect(_on_change_trigger)

func _on_change_trigger(_type:TRIGGER_TYPES, _flg:bool):
	if _type == trigger_base.TRIGGER_TYPES.FIRE:
		fire_trigger = _flg
