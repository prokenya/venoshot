shader_type canvas_item;

uniform vec4 target_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); 
uniform vec4 wave_color   : source_color = vec4(0.2, 0.6, 1.0, 0.5); 
uniform vec4 base_color   : source_color = vec4(0.0, 0.0, 0.0, 0.0);
uniform float speed = 1.0;  
uniform float frequency = 5.0; 

void fragment() {
    if (distance(COLOR, target_color) < 0.9) {
		
        float wave = sin(UV.y * frequency - TIME * speed);
        float mask = (wave * 0.5 + 0.5);

        COLOR = mix(base_color, wave_color , mask);
    }
}
