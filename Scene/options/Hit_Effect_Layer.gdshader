shader_type canvas_item;

uniform float strength : hint_range(0.0, 1.0) = 0.0;
uniform float thickness : hint_range(0.01, 0.3) = 0.08;
uniform float wobble_strength : hint_range(0.0, 0.05) = 0.02;
uniform float wobble_speed : hint_range(0.0, 10.0) = 4.0;
uniform vec4 damage_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

void fragment() {
    vec2 uv = SCREEN_UV;

    // ノイズによる縁の歪み
    float n = noise(uv * 10.0 + TIME * wobble_speed);
    float distorted = n * wobble_strength * strength;

    float edge_dist = min(
        min(uv.x, 1.0 - uv.x),
        min(uv.y, 1.0 - uv.y)
    );

    float mask = smoothstep(
        thickness + distorted,
        0.0,
        edge_dist
    );

    // 心拍っぽい強弱
    float pulse = 0.85 + 0.15 * sin(TIME * 12.0);

    COLOR = vec4(
        damage_color.rgb,
        mask * strength * pulse
    );
}
