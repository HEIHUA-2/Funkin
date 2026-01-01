#pragma header

// by HeiHua

uniform vec2 blur_size;

const vec2 textureSize = 1.0 / vec2(1280.0, 720.0);

const float sigma = 0.10132118364233777144387946320973;
const float twoSigma2 = 2.0 * sigma;
const float invTwoSigma2 = 1.0 / twoSigma2;
const float invSqrtTwoPiSigma = sqrt(3.1415926 * twoSigma2);
const float quality = 4.0;
const float q = quality * 0.5;

const float quality_max = BLUR_QUALITY;
const float q_max = 1.0 / quality_max * 0.5;
void main()
{
	vec2 uv = openfl_TextureCoordv;
	if (all(lessThan(abs(blur_size), vec2(0.0002))))
	{
		gl_FragColor = texture2D(bitmap, uv);
		return;
	}

	float kernelRadius = clamp(1.0 / length(blur_size) * q, q_max, 1.0);

	vec2 size = textureSize * blur_size;
	float totalWeight = 0.0;
	vec4 accumColor = vec4(0.0);

	for (float i = -1.0; i <= 1.0; i += kernelRadius)
	{
		float weight = exp(-(i*i) * invTwoSigma2) * invSqrtTwoPiSigma;
		
		vec2 offset = size * i;
		accumColor += texture2D(bitmap, uv + offset) * weight;
		totalWeight += weight;
	}

	gl_FragColor = accumColor / totalWeight;
}