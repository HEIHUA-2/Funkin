#pragma header

// by HeiHua

uniform float iTime;
uniform float amount;

float hash(float v) {
	return fract(sin(v * 12.9898) * 43758.5453) - 0.5;
}

float hash(in vec2 _v) {
	return fract(sin(dot(_v, vec2(89.44, 19.36))) * 22189.22) - 0.5;
}

float optimizedNoise(vec2 uv) {
	vec2 f = floor(uv);
	return hash(f * 0.5) + hash(f + 1.0);
}

void main() {
	vec2 uv = openfl_TextureCoordv;

	if (amount > 0.0) {
		float yCoord = uv.y * 50.0;
		
		float offset = 0.0;
		float noiseVal = optimizedNoise(vec2(yCoord * 2.0, iTime * 60.0)) * 1.25;
		offset = noiseVal * 0.015 * amount;

		vec2 baseUV = uv + vec2(offset, 0.0);
		vec3 color = texture2D(bitmap, baseUV).rgb;
		
		gl_FragColor = vec4(color, 1.0);
	}
	else
		gl_FragColor = vec4(texture2D(bitmap, uv).rgb, 1.0);
}