extends Area2D

var actor:actor_base

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(_area:Area2D):
	## expだったらtargetをセット
	if _area is hitbox:
		if _area.actor is exp_ball:
			_area.actor.target_actor = actor
			_area.actor.state = actor_base.STATE.MOVE

func _on_area_exited(_area:Area2D):
	pass

func init_entity():
	pass
	
