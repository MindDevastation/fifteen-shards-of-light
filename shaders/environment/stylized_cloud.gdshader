shader_type spatial;
render_mode unshaded, cull_back, diffuse_lambert, specular_disabled;

uniform vec4 top_color : source_color = vec4(0.91, 0.93, 0.95, 1.0);
uniform vec4 middle_color : source_color = vec4(0.80, 0.84, 0.88, 1.0);
uniform vec4 bottom_color : source_color = vec4(0.64, 0.70, 0.76, 1.0);
uniform sampler2D cloud_noise;
uniform float noise_influence : hint_range(0.0, 0.10) = 0.055;

void fragment() {
	float vertical = clamp(UV.y, 0.0, 1.0);
	vec3 lower = mix(bottom_color.rgb, middle_color.rgb, smoothstep(0.0, 0.58, vertical));
	vec3 upper = mix(middle_color.rgb, top_color.rgb, smoothstep(0.42, 1.0, vertical));
	vec3 gradient = mix(lower, upper, smoothstep(0.35, 0.75, vertical));
	float n1 = texture(cloud_noise, UV * 0.65).r;
	float n2 = texture(cloud_noise, UV * 1.15 + vec2(0.17, 0.11)).r;
	float n3 = texture(cloud_noise, UV * 1.80 + vec2(0.41, 0.23)).r;
	float low_frequency_noise = ((n1 * 0.58 + n2 * 0.30 + n3 * 0.12) - 0.5) * 2.0;
	ALBEDO = clamp(gradient + low_frequency_noise * noise_influence, vec3(0.58), vec3(0.98));
	ALPHA = 1.0;
}
