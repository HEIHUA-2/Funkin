#pragma header

// by HeiHua

#define resolution vec2(0.01, 0.01777777777777777777777777777778)
#define iResolution vec2(1280.0, 720.0)

varying vec2 fragCoord;

uniform float iTime;
uniform vec2 cameraOffset;
uniform float cameraZoom;
uniform float snowAmount;

float cameraZoomFactor;

float snow(vec2 uv, float scale) {
	vec2 effect = cameraOffset * resolution;
	float invScale = 1.0 / scale;

	uv = uv * (scale * cameraZoomFactor);

	float timeOffset = iTime * invScale;
	uv += effect * invScale + timeOffset;

	uv.x += sin(uv.y + iTime * 0.5) * invScale;

	uv *= scale;

	vec2 s = floor(uv);
	vec2 f = fract(uv) - (1.0 - snowAmount);

	vec2 v = s + scale;
	vec2 m = vec2(
		7.0 * v.x + 3.0 * v.y,
		6.0 * v.x + 5.0 * v.y
	);

	vec2 noise = fract(sin(m) * 5.0);
	vec2 p = vec2(0.5) + 0.5 * sin(11.0 * noise) - f;
	
	return smoothstep(0.0175, length(p), sin(f.x + f.y) * 0.01);
}

void main() {
	cameraZoomFactor = 0.2 / cameraZoom;

	float c = 0.0;
	float a = 1.0;

	for (float i = 3.0; i <= 8.0; i += SNOW_QUALITY)
	{
		c += snow(fragCoord, i) * a;
		a -= 0.025;
	}


	vec4 originalColor = texture2D(bitmap, openfl_TextureCoordv);

	originalColor.rgb += c * 0.15;
	
	gl_FragColor = originalColor;
}