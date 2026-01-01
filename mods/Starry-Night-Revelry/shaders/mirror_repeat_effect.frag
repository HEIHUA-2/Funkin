#pragma header

// by HeiHua

void main() {
	vec2 uv = mod(openfl_TextureCoordv, 2.0);

	gl_FragColor = texture2D(bitmap, 1.0 - abs(2.0 * fract(uv * 0.5) - 1.0));
}