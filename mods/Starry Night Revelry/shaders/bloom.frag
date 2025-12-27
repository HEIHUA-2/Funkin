#pragma header

// by HeiHua

uniform float A;
uniform float DIM;
uniform float QUALITYS;
uniform float SIZE;

#define pi 6.283185307179586476925286766559
#define uv openfl_TextureCoordv

vec3 accColor = vec3(0.0);

float stepQ;
float stepD;
float dimDir;

void main(void)
{
	float QUALITY = floor(SIZE * QUALITYS);
	float DIRECTIONS = floor(QUALITY * pi);
	vec2 SR = SIZE / openfl_TextureSize;

	gl_FragColor = texture2D(bitmap, uv);
	float L = length(gl_FragColor.rgb);
	SR /= L + 1.0;

	stepQ = 1.0 / QUALITY * (L + 1.0);
	stepD = pi / DIRECTIONS * (L + 1.0);
	dimDir = A * QUALITY * DIRECTIONS * pi;

	for (float i = stepQ; i <= 1.0; i += stepQ)
	{
		vec2 off = SR * i;
		for (float d = 0.0; d < pi; d += stepD / i)
		{
			vec3 c = texture2D(bitmap, uv + vec2(cos(d), sin(d)) * off).rgb;
			if (L >= length(c))
				accColor += gl_FragColor.rgb / i;
			else
				accColor += c / i;
		}
	}

	gl_FragColor.rgb *= 1.0 - A;
	gl_FragColor.rgb += accColor / dimDir;
	gl_FragColor *= DIM;
}