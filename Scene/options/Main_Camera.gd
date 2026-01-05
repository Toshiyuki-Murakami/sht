extends Camera2D

@export var max_offset:float = 64.0
@export var decay:float = 8.0   # 減衰速度

var trauma:float = 0.0
var noise := FastNoiseLite.new()
var time:float = 0.0

func _ready():
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 20.0
	
	Signals.hit_player.connect(_on_hit_player)

func _on_hit_player(_hp:int, _damage:int):
	add_shake(0.8)

func add_shake(amount: float):
	trauma = clamp(trauma + amount, 0.0, 1.0)

func _process(_delta:float):
	if trauma <= 0.0:
		offset = Vector2.ZERO
		return

	time += _delta * 100.0
	var shake:float = trauma * trauma

	offset.x = noise.get_noise_1d(time) * max_offset * shake
	offset.y = noise.get_noise_1d(time + 1000) * max_offset * shake

	trauma = max(trauma - decay * _delta, 0.0)
