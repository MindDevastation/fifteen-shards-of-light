shader_type spatial;
render_mode blend_mix, unshaded, cull_disabled, depth_draw_never;

uniform vec4 veil_color : source_color = vec4(1.0, 0.58, 0.25, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec2 c = UV - vec2(0.5);
	c.y *= 0.82;
	float r = length(c);
	float vertical = 1.0 - smoothstep(0.22, 0.54, r);
	float center = smoothstep(0.03, 0.18, r);
	ALBEDO = veil_color.rgb;
	ALPHA = vertical * center * activation * 0.14;
	EMISSION = veil_color.rgb * ALPHA * 0.60;
}
