#pragma header

uniform vec2 hueShift;

void main() {
	gl_FragColor = texture2D(bitmap, openfl_TextureCoordv);

	float c = hueShift.x;
	float s = hueShift.y;

	mat3 hueMatrix = mat3(
		0.299 + 0.701 * c + 0.168 * s,
		0.587 - 0.587 * c + 0.330 * s,
		0.114 - 0.114 * c - 0.497 * s,
		
		0.299 - 0.299 * c - 0.328 * s,
		0.587 + 0.413 * c + 0.035 * s,
		0.114 - 0.114 * c + 0.292 * s,
		
		0.299 - 0.300 * c + 1.250 * s,
		0.587 - 0.588 * c - 1.050 * s,
		0.114 + 0.886 * c - 0.203 * s
	);

	gl_FragColor.rgb *= hueMatrix;
}