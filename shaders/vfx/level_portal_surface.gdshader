shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;
uniform sampler2D swirl_noise;
uniform vec4 portal_color : source_color = vec4(1.0, 0.78, 0.36, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;
void fragment(){
 vec2 c=UV-vec2(0.5); float r=length(c); float a=atan(c.y,c.x);
 float swirl=texture(swirl_noise, vec2(r*1.8, a*0.159 + TIME*0.045)).r;
 float disc=smoothstep(0.52,0.42,r)*smoothstep(0.05,0.18,r);
 ALBEDO=portal_color.rgb; ALPHA=disc*activation*mix(0.25,0.72,swirl); EMISSION=portal_color.rgb*ALPHA*1.8;
}
