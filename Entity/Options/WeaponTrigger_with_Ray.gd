extends weapon_trigger

@onready var ray_cast_2d: RayCast2D = $RayCast2D

## ターゲットの射程
@export var ray_range:float = 500.0


func _ready() -> void:
	super()
	ray_cast_2d.target_position.x = ray_range

func trigger():
	## Rayにかかってなければ射撃しない
	if !ray_cast_2d.is_colliding():
		return
	super()
