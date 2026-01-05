extends Node2D
class_name actor_controller_base

var actor:actor_base

func init_entity():
	actor.change_activate.connect(_on_change_activate)
	actor.change_deactivate.connect(_on_change_deactivate)

func _on_change_activate(_data:Dictionary):
	set_process(true)

func _on_change_deactivate():
	set_process(false)
