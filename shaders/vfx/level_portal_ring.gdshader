shader_type spatial;
render_mode blend_add, unshaded, cull_disabled;
uniform vec4 ring_color : source_color = vec4(1.0,0.68,0.28,1.0);
uniform float activation : hint_range(0.0,1.0)=0.0;
void fragment(){ALBEDO=ring_color.rgb; ALPHA=activation*0.72; EMISSION=ring_color.rgb*activation*1.2;}
