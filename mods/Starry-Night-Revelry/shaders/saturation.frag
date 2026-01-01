#pragma header

// by HeiHua

uniform float saturation;
uniform float offset;
uniform float multiply;
uniform float luminance_contrast;

void main() {
	vec4 color = texture2D(bitmap, openfl_TextureCoordv) * luminance_contrast;

	gl_FragColor = vec4((mix(vec3(dot(color.rgb, vec3(0.2126, 0.7152, 0.0722))), color.rgb, saturation) - offset) * saturation * multiply + offset, color.a);
}