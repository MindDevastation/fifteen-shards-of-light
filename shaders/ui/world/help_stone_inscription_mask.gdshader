shader_type spatial;
render_mode blend_mix, unshaded, cull_disabled, depth_prepass_alpha;

uniform vec4 stone_tint : source_color = vec4(0.34, 0.30, 0.25, 0.92);
uniform vec4 age_variation : source_color = vec4(0.20, 0.18, 0.15, 1.0);
uniform float edge_softness : hint_range(0.01, 0.35) = 0.16;
uniform float edge_wobble : hint_range(0.0, 0.25) = 0.09;
uniform float surface_variation : hint_range(0.0, 0.35) = 0.16;

float hash(vec2 p) {
	p = fract(p * vec2(123.34, 456.21));
	p += dot(p, p + 45.32);
	return fract(p.x * p.y);
}

float value_noise(vec2 uv) {
	vec2 i = floor(uv);
	vec2 f = fract(uv);
	float a = hash(i);
	float b = hash(i + vec2(1.0, 0.0));
	float c = hash(i + vec2(0.0, 1.0));
	float d = hash(i + vec2(1.0, 1.0));
	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

void fragment() {
	vec2 centered = abs(UV - vec2(0.5));
	float horizontal = smoothstep(0.50, 0.50 - edge_softness, centered.x + value_noise(UV * 6.0) * edge_wobble);
	float vertical = smoothstep(0.50, 0.50 - edge_softness, centered.y + value_noise(UV * 7.0 + vec2(5.1, 2.8)) * edge_wobble);
	float organic_mask = horizontal * vertical;
	float grain = value_noise(UV * 18.0) * surface_variation;
	ALBEDO = mix(stone_tint.rgb, age_variation.rgb, grain);
	ALPHA = organic_mask * stone_tint.a;
	EMISSION = ALBEDO * 0.025;
}
