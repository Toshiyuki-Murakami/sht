extends actor_controller_base

@export var triggerbase:trigger_base


func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if triggerbase.fire_trigger:
		trigger()


func trigger():
	for _node in get_children():
		if _node is weapon_trigger:
			_node.trigger()
	
