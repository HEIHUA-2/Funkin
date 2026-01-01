#pragma header

// by HeiHua

uniform float iTime;
uniform float amount;

float simpleHash(float v) {
	return fract(sin(v * 12.9898) * 43758.5453) - 0.5;
}

float simpleHash(vec2 v) {
	return fract(cos(dot(v, vec2(0.3183099, 0.3678794))) * 43758.5453) - 0.5;
}

void main() {
	vec2 uv = openfl_TextureCoordv;

	float timeHash = simpleHash(uv.y * 10.0 + iTime * 2.0);
	vec2 grid = vec2(uv.y * 50.0, iTime * 25.0);
	float patternHash = simpleHash(floor(grid) * 0.5);

	float offset = (timeHash + patternHash) * 0.125 * amount;
	uv.x += offset * smoothstep(0.0, 1.0, abs(offset));

	vec4 color = texture2D(bitmap, uv);

	gl_FragColor = vec4(color.rgb - vec3(0.5, 0.5, 0.0) + color.a * 0.5, 0.004);
}