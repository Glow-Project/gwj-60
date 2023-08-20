shader_type canvas_item;

void vertex() {
	VERTEX.y += 0.5 * sin(TIME * VERTEX.x * 0.1);
}
