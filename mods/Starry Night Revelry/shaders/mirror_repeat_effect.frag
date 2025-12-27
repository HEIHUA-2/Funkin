#pragma header

uniform float x;
uniform float y;
uniform float zoom;
uniform float angle;


vec2 xy;
vec2 uv;
float rotation;
float angleMod;
void main() {
	uv = openfl_TextureCoordv - 0.5;

	angleMod = mod(angle, 360.0);
	if (angleMod != 0.0) {
		rotation = angleMod * 0.0174532925199;// 3.1415926535897 / 180
		xy = vec2(cos(rotation), sin(rotation));

		uv *= mat2(
			vec2(xy.x, -xy.y / (openfl_TextureSize.x / openfl_TextureSize.y)),
			vec2(xy.y / (openfl_TextureSize.y / openfl_TextureSize.x), xy.x)
		);
	}

	uv = mod(uv * zoom + 0.5 + vec2(x, y), 2.0);
	gl_FragColor = texture2D(bitmap, abs(uv - (vec2(float(int(uv.x)), float(int(uv.y))) * 2.0)));
}