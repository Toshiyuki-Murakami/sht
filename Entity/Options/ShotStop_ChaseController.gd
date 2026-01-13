extends chase_controller
class_name shotstop_chase_controller

func face():
	if actor.hold == true:
		return
	super()

func homing(_delta:float):
	if actor.hold == true:
		return
	super(_delta)
