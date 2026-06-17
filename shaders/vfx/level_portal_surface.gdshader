shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;

uniform sampler2D swirl_noise;
uniform vec4 portal_color : source_color = vec4(0.92, 0.55, 0.18, 1.0);
uniform vec4 strand_color : source_color = vec4(1.0, 0.78, 0.36, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;
uniform float phase_offset = 0.0;
uniform float strand_density : hint_range(1.0, 32.0) = 6.0;
uniform float radial_density : hint_range(1.0, 36.0) = 24.0;
uniform float rotation_speed : hint_range(0.0, 1.2) = 0.42;
uniform float layer_alpha : hint_range(0.0, 1.0) = 0.42;
uniform float base_alpha : hint_range(0.0, 0.12) = 0.045;
uniform float arm_alpha : hint_range(0.0, 1.0) = 0.27;
uniform float emission_strength : hint_range(0.0, 2.0) = 1.15;

float strand_mask(float value, float width) {
	float centered = abs(fract(value) - 0.5);
	return 1.0 - smoothstep(0.0, width, centered);
}

void fragment() {
	vec2 c = UV - vec2(0.5);
	float r = length(c);
	float angle = atan(c.y, c.x) * 0.15915494;
	float oval = 1.0 - smoothstep(0.40, 0.48, r);
	float center_open = smoothstep(0.055, 0.18, r);
	float body = oval * center_open;
	float clockwise_time = -TIME * rotation_speed + phase_offset;
	float low_noise = texture(swirl_noise, vec2(r * 0.72 + phase_offset, angle + clockwise_time * 0.45)).r;
	float arm_coordinate = angle * 6.0 + r * radial_density + clockwise_time + low_noise * 0.12;
	float main_arms = strand_mask(arm_coordinate, 0.245);
	float detail_a = strand_mask(arm_coordinate + sin(r * 18.0 + clockwise_time * 0.65) * 0.045 + 0.18, 0.105) * main_arms * 0.32;
	float detail_b = strand_mask(arm_coordinate + low_noise * 0.16 - 0.23, 0.075) * main_arms * 0.20;
	float strands = clamp(main_arms + detail_a + detail_b, 0.0, 1.0);
	float volume_fill = body * base_alpha * layer_alpha;
	float strand_alpha = strands * body * layer_alpha * arm_alpha;
	float edge_alpha = (1.0 - smoothstep(0.28, 0.47, r)) * oval * 0.055 * layer_alpha;
	float alpha = (volume_fill + strand_alpha + edge_alpha) * activation;
	ALBEDO = mix(portal_color.rgb, strand_color.rgb, strands * 0.78);
	ALPHA = alpha;
	EMISSION = ALBEDO * alpha * emission_strength;
}
