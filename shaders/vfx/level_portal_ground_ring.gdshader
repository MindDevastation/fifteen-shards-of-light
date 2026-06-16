shader_type spatial;
render_mode blend_add, unshaded, cull_disabled, depth_draw_never;
uniform sampler2D swirl_noise; uniform float activation:hint_range(0.0,1.0)=0.0; uniform vec4 ring_color:source_color=vec4(1.0,0.58,0.22,1.0);
void fragment(){vec2 c=UV*2.0-1.0;float r=length(c);float ring=smoothstep(0.88,0.65,r)*smoothstep(0.36,0.48,r);float n=texture(swirl_noise,UV+vec2(TIME*0.01)).r;ALBEDO=ring_color.rgb;ALPHA=ring*activation*mix(0.2,0.62,n);EMISSION=ring_color.rgb*ALPHA;}
