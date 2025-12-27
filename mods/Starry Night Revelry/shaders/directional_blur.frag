#pragma header

// A simple directional blur that doesn't brighten the image, based on https://www.shadertoy.com/view/WdSXWD

uniform float strength;
uniform int samples;

vec3 acc;
float delta;
float i;
vec4 dirBlur(sampler2D tex, vec2 uv, vec2 angle) {
	acc = vec3(0.0);
	delta = 2.0 / float(samples);

	for(i = -1.0; i <= 1.0; i += delta)
		acc += texture2D(tex, uv - vec2(angle.x, angle.y) * i).rgb;
	for(i = -1.0; i <= 1.0; i += delta)
		acc += texture2D(tex, uv - vec2(angle.y, angle.x) * i).rgb;

	return vec4(acc * delta * 0.3025, 1.0);
}


float r;
void main() {
	if (texture2D(bitmap, openfl_TextureCoordv).r <= 0.85) {
		r = radians(90.0);

		gl_FragColor = dirBlur(bitmap, openfl_TextureCoordv, strength * vec2(sin(r), cos(r)));
	} else {
		gl_FragColor = vec4(1.0);
	}
}