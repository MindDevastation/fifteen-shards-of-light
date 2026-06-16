shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;

uniform sampler2D swirl_noise;
uniform vec4 portal_color : source_color = vec4(1.0, 0.74, 0.34, 1.0);
uniform vec4 thread_color : source_color = vec4(1.0, 0.93, 0.68, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;
// Slow clockwise woven spiral; keep restrained for Level 01 finale readability.

float line_mask(float value, float width) {
	return 1.0 - smoothstep(0.0, width, abs(fract(value) - 0.5));
}

void fragment() {
	vec2 c = UV - vec2(0.5);
	c.y *= 1.16;
	float r = length(c);
	float a = atan(c.y, c.x);
	float clockwise = -TIME * 0.09;
	float spiral_a = a * 0.15915494 + r * 1.7 + clockwise;
	float spiral_b = -a * 0.15915494 + r * 1.35 + clockwise * 0.72;
	float noise = texture(swirl_noise, vec2(r * 1.25, spiral_a)).r;
	float body = smoothstep(0.55, 0.38, r) * smoothstep(0.035, 0.16, r);
	float thread = max(line_mask(spiral_a * 6.0 + noise * 0.22, 0.085), line_mask(spiral_b * 5.0 - noise * 0.18, 0.075));
	float soft_threads = mix(0.18, 0.82, thread) * body;
	float edge_fade = smoothstep(0.56, 0.46, r);
	ALBEDO = mix(portal_color.rgb, thread_color.rgb, thread * 0.72);
	ALPHA = soft_threads * edge_fade * activation * 0.78;
	EMISSION = ALBEDO * ALPHA * 2.25;
}
