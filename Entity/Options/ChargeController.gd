extends actor_controller_base

@export var max_charge:float = 3.0

var charge_timer:float = 0.0

func _ready():
	Signals.start_charge.connect(_on_start_charge)
	Signals.shot_charge.connect(_on_shot_charge)

func _process(_delta: float) -> void:
	charge_timer += _delta
	if charge_timer > max_charge:
		charge_timer = max_charge
	Signals.update_chage.emit(charge_timer, max_charge)

func _on_start_charge():
	start_charge()

func _on_shot_charge():
	end_charge()

func start_charge():
	set_process(true)
	charge_timer = 0.0
	print_debug('start')

func end_charge():
	charge_timer = 0.0
	Signals.update_chage.emit(charge_timer, max_charge)
	set_process(false)
	print_debug('end')
	
