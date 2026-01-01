#pragma header

uniform vec2 pixelSize;

void main(void) {
	openfl_Alphav = openfl_Alpha;
	openfl_TextureCoordv = openfl_TextureCoord;

	if (openfl_HasColorTransform) {
		openfl_ColorMultiplierv = openfl_ColorMultiplier;
		openfl_ColorOffsetv = openfl_ColorOffset / 255.0;
	}

	openfl_Alphav = openfl_Alpha * alpha;

	if (hasColorTransform) {
		openfl_ColorOffsetv = colorOffset / 255.0;
		openfl_ColorMultiplierv = colorMultiplier;
	}

	vec4 position = openfl_Matrix * openfl_Position;

  if (pixelSize.x > 0.0 && pixelSize.y > 0.0)
	  position.xy = floor(position.xy / pixelSize + 0.5) * pixelSize;

	gl_Position = position;
}