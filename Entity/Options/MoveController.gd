extends actor_controller_base
class_name move_controler


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	move(_delta)


func move(_delta:float):
	if !actor:
		return
	if actor.state != actor_base.STATE.MOVE:
		return
	if actor.velocity != Vector2.ZERO:
		actor.translate(actor.velocity * _delta)
