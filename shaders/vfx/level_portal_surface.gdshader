shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;

uniform sampler2D swirl_noise;
uniform vec4 portal_color : source_color = vec4(0.92, 0.55, 0.18, 1.0);
uniform vec4 strand_color : source_color = vec4(1.0, 0.78, 0.36, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;
uniform float phase_offset = 0.0;
uniform float strand_density : hint_range(1.0, 32.0) = 18.0;
uniform float radial_density : hint_range(1.0, 36.0) = 24.0;
uniform float rotation_speed : hint_range(0.0, 0.5) = 0.085;
uniform float layer_alpha : hint_range(0.0, 1.0) = 0.55;

float strand_mask(float value, float width) {
	float centered = abs(fract(value) - 0.5);
	return 1.0 - smoothstep(0.0, width, centered);
}

void fragment() {
	vec2 c = UV - vec2(0.5);
	c.y *= 0.70;
	float r = length(c);
	float angle = atan(c.y, c.x) * 0.15915494;
	float oval = 1.0 - smoothstep(0.43, 0.51, r);
	float center_open = smoothstep(0.045, 0.17, r);
	float body = oval * center_open;
	float clockwise_time = -TIME * rotation_speed + phase_offset;
	float low_noise = texture(swirl_noise, vec2(r * 0.72 + phase_offset, angle + clockwise_time * 0.45)).r;
	float primary = strand_mask(angle * strand_density + r * radial_density + clockwise_time + low_noise * 0.12, 0.060);
	float secondary = strand_mask(angle * (strand_density + 5.0) - r * (radial_density * 0.86) + clockwise_time * 0.92 + 0.37 + phase_offset, 0.050) * 0.74;
	float tertiary = strand_mask(angle * (strand_density * 0.62) + r * (radial_density * 1.18) - clockwise_time * 0.68 + 0.61 + phase_offset, 0.038) * 0.48;
	float strands = clamp(primary + secondary + tertiary, 0.0, 1.0);
	float base_alpha = body * 0.030;
	float strand_alpha = strands * body * layer_alpha * 0.58;
	float edge_alpha = (1.0 - smoothstep(0.34, 0.50, r)) * oval * 0.07;
	float alpha = (base_alpha + strand_alpha + edge_alpha) * activation;
	ALBEDO = mix(portal_color.rgb, strand_color.rgb, strands * 0.72);
	ALPHA = alpha;
	EMISSION = ALBEDO * alpha * 1.18;
}
