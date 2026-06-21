shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;
uniform sampler2D noise_texture;
uniform vec4 ring_color : source_color = vec4(1.0, 0.64, 0.24, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;
void fragment() {
	vec2 centered = UV * 2.0 - 1.0;
	float radius = length(centered);
	float ring = smoothstep(0.75, 0.56, radius) * smoothstep(0.20, 0.38, radius);
	float n = texture(noise_texture, UV + vec2(TIME * 0.015, -TIME * 0.01)).r;
	ALBEDO = ring_color.rgb;
	ALPHA = ring * activation * mix(0.25, 0.75, n);
	EMISSION = ring_color.rgb * ALPHA;
}
