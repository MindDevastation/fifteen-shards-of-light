shader_type spatial;
render_mode blend_add, unshaded, cull_disabled;
uniform vec4 ring_color : source_color = vec4(1.0,0.62,0.24,1.0);
uniform float activation : hint_range(0.0,1.0)=0.0;
void fragment(){ALBEDO=ring_color.rgb; ALPHA=activation*0.30; EMISSION=ring_color.rgb*activation*0.42;}
