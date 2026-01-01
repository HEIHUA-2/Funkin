#pragma header

uniform vec4 frameUV;

uniform bool downscroll;
uniform bool isSustainNote;
uniform float songPosition;
uniform float curBeat;
uniform float scrollSpeed;
uniform float strumID;
uniform float strumLineID;

void main()
{
	vec4 color = texture2D(bitmap, openfl_TextureCoordv);

	if (!hasTransform || color.a <= 0.0) {

		#pragma modifierFunctions

		gl_FragColor = color;
		return;
	}

	if (hasColorTransform) {
		vec4 transformed = vec4(0.0);
		vec3 premultiplied = color.rgb / color.a;

		transformed.rgb = premultiplied * openfl_ColorMultiplierv.xyz + openfl_ColorOffsetv.xyz;
		transformed.a = color.a * openfl_ColorMultiplierv.w + openfl_ColorOffsetv.w;
		transformed = clamp(transformed, 0.0, 1.0);

		transformed *= openfl_Alphav;
		color = transformed;
	}
	else color *= openfl_Alphav;

	#pragma modifierFunctions
	
	gl_FragColor = color;
}