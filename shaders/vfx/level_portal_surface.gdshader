shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;

uniform sampler2D swirl_noise;
uniform vec4 portal_color : source_color = vec4(0.92, 0.55, 0.18, 1.0);
uniform vec4 strand_color : source_color = vec4(1.0, 0.78, 0.36, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;
uniform float phase_offset = 0.0;
uniform float strand_density : hint_range(1.0, 32.0) = 6.0;
uniform float radial_density : hint_range(1.0, 36.0) = 18.0;
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
	float counterclockwise_time = TIME * rotation_speed + phase_offset;
	float low_noise = texture(swirl_noise, vec2(r * 0.72 + phase_offset, angle + counterclockwise_time * 0.45)).r;
	float arm_coordinate = angle * strand_density + r * radial_density + counterclockwise_time + low_noise * 0.18;
	float sleeve_core = strand_mask(arm_coordinate, 0.38);
	float sleeve_body = pow(sleeve_core, 0.82);
	float veil_noise = 0.82 + low_noise * 0.18;
	float strands = sleeve_body * veil_noise;
	float volume_fill = body * base_alpha * layer_alpha;
	float strand_alpha = strands * body * layer_alpha * arm_alpha;
	float edge_alpha = (1.0 - smoothstep(0.28, 0.47, r)) * oval * 0.075 * layer_alpha;
	float alpha = (volume_fill + strand_alpha + edge_alpha) * activation;
	ALBEDO = mix(portal_color.rgb, strand_color.rgb, strands * 0.78);
	ALPHA = alpha;
	EMISSION = ALBEDO * alpha * emission_strength;
}
