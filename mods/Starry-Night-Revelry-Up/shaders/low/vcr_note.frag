#pragma header

// by HeiHua

uniform float iTime;
uniform float amount;

float simpleHash(float v) {
	return fract(sin(v * 12.9898) * 43758.5453) - 0.5;
}

void main() {
	vec2 uv = openfl_TextureCoordv;

	float timeHash = simpleHash(uv.y * 50.0 + iTime);
	vec2 grid = vec2(uv.y * 25.0, iTime);

	float offset = (timeHash) * 0.1 * amount;

	float edgeFactor = clamp(abs(offset) * 2.0, 0.0, 1.0);
	uv.x += offset * edgeFactor;

	vec4 color = texture2D(bitmap, uv);

	gl_FragColor = vec4(color.rgb - vec3(0.5, 0.5, 0.0) + color.a * 0.5, 0.004);
}