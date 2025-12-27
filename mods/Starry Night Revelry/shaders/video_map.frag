#pragma header

// by HeiHua

uniform sampler2D video;

void main() {
	gl_FragColor = texture2D(video, openfl_TextureCoordv);
}