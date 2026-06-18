shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;

uniform vec4 base_color : source_color = vec4(1.0, 0.74, 0.32, 1.0);
uniform float emission_strength : hint_range(0.0, 4.0) = 1.65;

void fragment() {
	vec4 instance_tint = COLOR;
	vec3 tinted_color = base_color.rgb * instance_tint.rgb;
	ALBEDO = tinted_color;
	ALPHA = base_color.a * instance_tint.a;
	EMISSION = tinted_color * emission_strength * instance_tint.a;
}
