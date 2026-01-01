#pragma header

/*
	-- [ HeiHua Modification ] -- https://github.com/HEIHUAa --

	Take warp texture, convert to luminance (or just use a single-channel texture to begin with),
	add time to luminance, use as lookup into sine function. Use resulting value to scale uv offsets
	for texture warping.

	Can use separate variables for X and Y offsets with slightly different speed/distance values to
	hide periodicity.

	Effect works better if warp texture's histogram is centered around 0.5,(so that the whole image
	doesn't tend in a single direction at once).
*/

uniform float iTime;

uniform sampler2D bitmap_warp;

const float pi = 6.28318530718;

float hash(float v) {
	return fract(sin(v * 12.9898) * 43758.5453) - 0.5;
}

void main()
{
	vec2 uv = openfl_TextureCoordv;

	float noise = hash(uv.x * uv.y + iTime) * 0.025;

	float offset = dot(texture2D(bitmap_warp, uv * (uv.x + uv.y)).rgb, vec3(0.299, 0.587, 0.114));

	float t = offset + iTime;

	vec2 warp = vec2(cos(pi * fract(t * 1.789475689)), sin(pi * fract(t)));

	vec2 offset_uv = uv + warp * 0.1;

	offset_uv.x += iTime;

	offset_uv = fract(offset_uv);

	gl_FragColor = applyFlixelEffects(texture2D(bitmap, fract(offset_uv * (uv.x + uv.y))) - 0.1 + noise) * 7.5;
}