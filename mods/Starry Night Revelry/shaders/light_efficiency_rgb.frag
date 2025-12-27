#pragma header

// by HeiHua

uniform float brightness;

float brightnes;
void main() {
	brightnes = brightness - openfl_TextureCoordv.y - .5;
	if (brightnes < 1.) brightnes = 1.;

	gl_FragColor = vec4(texture2D(bitmap, openfl_TextureCoordv).rgb * brightnes, 1.);
}