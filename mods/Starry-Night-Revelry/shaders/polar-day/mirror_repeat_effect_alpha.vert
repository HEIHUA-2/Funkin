#pragma header

// by HeiHua

uniform float x;
uniform float y;
uniform float zoom;
uniform float angle;

void main(void) {
	openfl_TextureCoordv = openfl_TextureCoord - 0.5;
	openfl_Alphav = openfl_Alpha * alpha;

	float angleMod = mod(angle, 360.0);
	if (angleMod != 0.0) {
		float rotation = angleMod * 0.0174532925199;
		vec2 xy = vec2(cos(rotation), sin(rotation));

		openfl_TextureCoordv *= mat2(
			vec2(xy.x, -xy.y / (openfl_TextureSize.x / openfl_TextureSize.y)),
			vec2(xy.y / (openfl_TextureSize.y / openfl_TextureSize.x), xy.x)
		);
	}

	openfl_TextureCoordv *= zoom;
	openfl_TextureCoordv += 0.5;
	openfl_TextureCoordv += vec2(x, y);

	gl_Position = openfl_Matrix * openfl_Position;
}