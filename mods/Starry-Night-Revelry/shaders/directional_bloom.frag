#pragma header

// by HeiHua

const vec2 blur_size = vec2(15.0, 0.0);
const vec2 size = vec2(0.00078125, 0.00138888888888888888888888888889) * blur_size;

const float sigma = 0.10132118364233777144387946320973;
const float twoSigma2 = 2.0 * sigma;
const float invTwoSigma2 = 1.0 / twoSigma2;
const float invSqrtTwoPiSigma = 1.0 / sqrt(3.1415926 * twoSigma2);

const float q = 2.0;
const float kernelRadius = 1.0 / q;

void main()
{
	vec2 uv = openfl_TextureCoordv;

	gl_FragColor = texture2D(bitmap, uv);

	if (gl_FragColor.r >= 0.85) {
		gl_FragColor = vec4(1.0);
		return;
	}
	
	float totalWeight = 0.0;
	vec4 accumColor = vec4(0.0);

	for (float i = -0.5; i <= 0.5; i += kernelRadius)
	{
		float weight = exp(-(i*i) * invTwoSigma2) * invSqrtTwoPiSigma;
		
		vec2 offset = size * i;
		accumColor += texture2D(bitmap, uv + offset) * weight;
		totalWeight += weight;
	}

	gl_FragColor = (accumColor / totalWeight - 0.2) * 1.5;
}