shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;
uniform sampler2D noise_texture;
uniform vec4 core_color : source_color = vec4(1.0, 0.78, 0.36, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;
uniform float softness : hint_range(0.1, 4.0) = 1.35;
uniform float scroll_speed = 0.045;
void fragment() {
	vec2 uv = UV;
	float edge = pow(1.0 - abs(uv.x - 0.5) * 2.0, softness);
	float rise = smoothstep(0.0, 0.18, uv.y) * (1.0 - smoothstep(0.92, 1.0, uv.y));
	float n = texture(noise_texture, vec2(uv.x * 0.65, uv.y * 0.45 - TIME * scroll_speed)).r;
	ALBEDO = core_color.rgb;
	ALPHA = edge * rise * activation * mix(0.26, 0.72, n);
	EMISSION = core_color.rgb * ALPHA * 1.6;
}
