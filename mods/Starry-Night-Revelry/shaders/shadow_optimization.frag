#pragma header

// by HeiHua

uniform float offsetX;
uniform float offsetY;
uniform float QUALITY;

varying vec3 v;

void main() {
	vec2 uvOffset = v.xy;
	vec2 delta = uvOffset * v.z;
	vec2 currentOffset = delta;
	float colorA = 0.0;

	for (int j = 0; j < int(QUALITY); j++) {
		vec2 coord = openfl_TextureCoordv + currentOffset;
		colorA += texture2D(bitmap, openfl_TextureCoordv + currentOffset).a;
		currentOffset += delta;
	}

	colorA += texture2D(bitmap, openfl_TextureCoordv).a;
	colorA = min(colorA, 1.0);

	gl_FragColor.a = colorA * openfl_Alphav;
}