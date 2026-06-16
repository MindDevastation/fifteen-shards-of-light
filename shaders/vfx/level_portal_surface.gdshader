shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;

uniform sampler2D swirl_noise;
uniform vec4 portal_color : source_color = vec4(1.0, 0.72, 0.34, 1.0);
uniform vec4 strand_color : source_color = vec4(1.0, 0.92, 0.66, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;

float strand_mask(float value, float width) {
	float centered = abs(fract(value) - 0.5);
	return 1.0 - smoothstep(0.0, width, centered);
}

void fragment() {
	vec2 centered_uv = UV - vec2(0.5);
	centered_uv.y *= 1.12;
	float r = length(centered_uv);
	float angle = atan(centered_uv.y, centered_uv.x) * 0.15915494;
	float body_outer = 1.0 - smoothstep(0.38, 0.55, r);
	float center_softness = smoothstep(0.035, 0.18, r);
	float edge_fade = 1.0 - smoothstep(0.46, 0.56, r);
	float body = body_outer * center_softness;
	float clockwise_time = -TIME * 0.045;
	float low_noise = texture(swirl_noise, vec2(r * 0.82 + 0.13, angle + clockwise_time * 0.35)).r;
	float primary = strand_mask(angle * 3.6 + r * 1.72 + clockwise_time + low_noise * 0.10, 0.075);
	float secondary = strand_mask(angle * 4.4 + r * 2.05 + clockwise_time * 0.82 + 0.31 + low_noise * 0.08, 0.055) * 0.58;
	float strands = clamp(primary + secondary, 0.0, 1.0);
	float base_alpha = body * 0.10;
	float strand_alpha = strands * body * 0.30;
	float rim_alpha = edge_fade * body_outer * 0.16;
	float alpha = (base_alpha + strand_alpha + rim_alpha) * activation;
	ALBEDO = mix(portal_color.rgb, strand_color.rgb, strands * 0.68);
	ALPHA = alpha;
	EMISSION = ALBEDO * alpha * 1.15;
}
