shader_type canvas_item;

void fragment() {
	if (COLOR == vec4(0, 0, 0, 1)) {
		COLOR = vec4(1);
	}
}
