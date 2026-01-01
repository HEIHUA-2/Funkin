#pragma header

uniform float iTime;

uniform sampler2D bitmap_for;

const float pi = 6.28318530718;

void main()
{
	float offset1 = dot(texture2D(bitmap_for, openfl_TextureCoordv * 0.1 - vec2(0.005 * iTime, 0.1)).rgb, vec3(0.5));
	float offset2 = dot(texture2D(bitmap_for, openfl_TextureCoordv * 0.1 + vec2(0.01 * iTime, 0.2)).rgb, vec3(0.5));
	float offset3 = dot(texture2D(bitmap_for, openfl_TextureCoordv * 0.1 + vec2(0.02 * iTime, -0.2)).rgb, vec3(0.5));

	gl_FragColor = texture2D(bitmap, openfl_TextureCoordv) * vec4((vec3(offset1 + offset2 + offset3) - 2.0) * 0.2 + 0.95, 1.0);
}