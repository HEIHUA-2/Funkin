#pragma header

uniform float iTime;

uniform sampler2D bitmap_reflection;

const float pi = 6.28318530718;

void main()
{
  vec2 uv = openfl_TextureCoordv * vec2(0.5, 2.5);
	float offset = dot(texture2D(bitmap_reflection, uv - vec2(0.005 * iTime, -0.1)).rgb, vec3(0.5));
	offset -= dot(texture2D(bitmap_reflection, uv + vec2(0.01 * iTime, 0.2)).rgb, vec3(0.5));

	gl_FragColor = texture2D(bitmap, openfl_TextureCoordv - vec2(0.0, offset) * 0.25);
}