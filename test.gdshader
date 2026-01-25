shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.0) = 0.45;   // 初期円半径
uniform float speed : hint_range(0.0, 2.0) = 0.6;    // 集まる速度
uniform float density : hint_range(1.0, 50.0) = 20.0; // 粒の数
uniform float size : hint_range(0.001, 0.05) = 0.01; // 粒サイズ
uniform vec4 color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    vec2 uv = UV * 2.0 - 1.0;   // -1 ～ 1
    float r = length(uv);
    float angle = atan(uv.y, uv.x);

    float t = TIME * speed;

    // 円周から中央へ縮む半径
    float moving_radius = radius - t;
    if (moving_radius < 0.0) discard;

    // 角度で粒を分割
    float slice = abs(sin(angle * density + t * 5.0));

    // 円周上に粒を作る
    float particle = smoothstep(size, 0.0, abs(r - moving_radius)) * step(0.95, slice);

    COLOR = vec4(color.rgb, particle * color.a);
}