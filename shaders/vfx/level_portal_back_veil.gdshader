shader_type spatial;
render_mode blend_mix, unshaded, cull_disabled, depth_draw_never;

uniform vec4 veil_color : source_color = vec4(0.08, 0.045, 0.025, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec2 c = UV - vec2(0.5);
	c.y *= 0.70;
	float r = length(c);
	float oval = 1.0 - smoothstep(0.38, 0.52, r);
	float center = smoothstep(0.04, 0.16, r);
	ALBEDO = veil_color.rgb;
	ALPHA = oval * center * activation * 0.10;
	EMISSION = vec3(0.0);
}
