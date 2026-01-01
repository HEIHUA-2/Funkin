#pragma header

uniform bool enabled;

void main(void) {
	openfl_TextureCoordv = openfl_TextureCoord;

  vec4 position = openfl_Position;

	if (!enabled) {
		position *= 0.0;
	}

	gl_Position = openfl_Matrix * position;
}