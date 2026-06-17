shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;

uniform vec4 ring_color : source_color = vec4(1.0, 0.62, 0.24, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;
uniform float ring_radius : hint_range(0.0, 1.0) = 0.92;
uniform float ring_width : hint_range(0.0, 0.20) = 0.035;
uniform float ring_alpha : hint_range(0.0, 1.0) = 0.12;
uniform float emission_strength : hint_range(0.0, 1.0) = 0.16;
uniform float edge_softness : hint_range(0.001, 0.10) = 0.025;

void fragment() {
	vec2 centered = (UV - vec2(0.5)) * 2.0;
	float distance_from_center = length(centered);
	float outer_mask = 1.0 - smoothstep(ring_radius, ring_radius + edge_softness, distance_from_center);
	float inner_edge = ring_radius - ring_width;
	float inner_mask = 1.0 - smoothstep(inner_edge - edge_softness, inner_edge, distance_from_center);
	float ring_mask = clamp(outer_mask - inner_mask, 0.0, 1.0);
	float alpha = ring_mask * ring_alpha * activation;
	ALBEDO = ring_color.rgb;
	ALPHA = alpha;
	EMISSION = ring_color.rgb * alpha * emission_strength;
}
