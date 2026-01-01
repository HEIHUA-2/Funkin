#pragma header

uniform float Intensity;
uniform float Dim;
uniform float Quality;
uniform float Size;

#define pi 6.283185307179586476925286766559
#define uv openfl_TextureCoordv

float getLuminance(vec3 rgb) {
	return dot(rgb, vec3(0.2126, 0.7152, 0.0722));
}

vec3 chooseBrighter(vec3 colorA, vec3 colorB) {
	float lumaA = getLuminance(colorA);
	float lumaB = getLuminance(colorB);
	return (lumaA > lumaB) ? colorA : colorB;
}

void main()
{
	gl_FragColor = texture2D(bitmap, uv);

	float luminance = max(length(gl_FragColor.rgb), 0.15);

	float luminance_2 = max(1.0 - luminance, 0.001);

	vec2 blurRadius = Size / openfl_TextureSize * luminance_2;

	float depthSample = floor(Size * Quality) * luminance_2;
	float angleSamples = floor(depthSample * pi);

	float sample = depthSample * angleSamples;

	float stepD = 1.0 / depthSample;
	float stepA = pi / angleSamples;

	vec3 blendColor = gl_FragColor.rgb;

	float dimDir = Quality * Size * pi + 1.0;

	for (float i = stepD; i <= 1.0; i += stepD)
		for (float d = 0.0; d < pi; d += stepA / i)
		{
			vec3 color = texture2D(bitmap, uv + vec2(cos(d) * blurRadius.x, sin(d) * blurRadius.y) * i).rgb;
			blendColor += color / i;
		}

	gl_FragColor.rgb = chooseBrighter(blendColor / dimDir * Quality * Intensity, gl_FragColor.rgb);
}