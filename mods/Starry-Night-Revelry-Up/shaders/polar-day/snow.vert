#pragma header

#define iResolution vec2(1280.0, 720.0)

// by HeiHua

varying vec2 fragCoord;

void main(void) {
	openfl_TextureCoordv = openfl_TextureCoord;

	fragCoord = (openfl_TextureCoord * iResolution * 2.0 - iResolution) / min(iResolution.x, iResolution.y);

	gl_Position = openfl_Matrix * openfl_Position;
}