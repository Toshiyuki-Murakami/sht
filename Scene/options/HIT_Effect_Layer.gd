extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

var shader_material:Material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shader_material = color_rect.material
	Signals.hit_player.connect(_on_hit)

func _on_hit(_hp:int, _damage:int):
	shader_material.set_shader_parameter("strength", 0.6)

	var tween = create_tween()
	tween.tween_property(
		shader_material,
		"shader_parameter/strength",
		0.0,
		0.3
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
