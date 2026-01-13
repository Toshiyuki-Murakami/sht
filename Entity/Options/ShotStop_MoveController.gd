extends move_controler
class_name shotstop_move_controler

func move(_delta:float):
	if actor.hold == true:
		return
	super(_delta)
