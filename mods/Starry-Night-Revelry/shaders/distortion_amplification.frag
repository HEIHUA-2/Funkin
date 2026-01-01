#pragma header

uniform float strength;

vec2 PincushionDistortion(in vec2 uv, float strength)
{
	vec2 st = uv - 0.5;
	float uvA = atan(st.x, st.y);
	float uvD = dot(st, st);
	return 0.5 + vec2(sin(uvA), cos(uvA)) * sqrt(uvD) * (1.0 - strength * uvD);
}

void main() {
	if (abs(strength) < 0.0001) {
		gl_FragColor = texture2D(bitmap, openfl_TextureCoordv);
		return;
	}

	vec2 uv = PincushionDistortion(openfl_TextureCoordv, strength);
	gl_FragColor = texture2D(bitmap, uv);
}