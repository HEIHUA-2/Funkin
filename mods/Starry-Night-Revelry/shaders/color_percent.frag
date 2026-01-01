#pragma header

// by HeiHua

uniform float percent;

uniform vec3 healthBarColorLeft;
uniform vec3 healthBarColorRight; 

void main() {
	float alpha = texture2D(bitmap, openfl_TextureCoordv).a * openfl_Alphav;

	vec3 finalColor = mix(healthBarColorLeft, healthBarColorRight, step(1.0 - (percent * 0.01), openfl_TextureCoordv.x));
	gl_FragColor = vec4(finalColor * alpha * 1.1111, alpha * 0.9);
}