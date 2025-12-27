#pragma header

vec4 new_texture2D(sampler2D bitmap, vec2 coord)
{
    vec4 color = texture2D(bitmap, coord);
    
    // Early exit for most common case (no transform)
    if (!hasTransform) {
        return color;
    }

    // Early alpha discard
    if (color.a <= 0.0) {
        return vec4(0.0);
    }

    // Fast path for alpha-only transform
    if (!hasColorTransform) {
        return color * openfl_Alphav;
    }

    // Optimized color transform calculations
    vec3 rgb = color.rgb / color.a;  // Premultiplied alpha correction
    
    // Vectorized color transform (avoids full matrix multiplication)
    vec4 transformed;
    transformed.rgb = rgb * openfl_ColorMultiplierv.xyz + openfl_ColorOffsetv.xyz;
    transformed.a = color.a * openfl_ColorMultiplierv.w + openfl_ColorOffsetv.w;
    transformed = clamp(transformed, 0.0, 1.0);

    // Final alpha application with branch prediction hint
    if (transformed.a > 0.0) {
        float finalAlpha = transformed.a * openfl_Alphav;
        return vec4(transformed.rgb * finalAlpha, finalAlpha);
    }
    return vec4(0.0);
}

uniform vec4 frameUV;

uniform bool downscroll;
uniform bool isSustainNote;
uniform float songPosition;
uniform float curBeat;
uniform float scrollSpeed;
uniform float strumID;
uniform float strumLineID;

#pragma modifierUniforms

void main()
{
	vec4 color = new_texture2D(bitmap, openfl_TextureCoordv);

	#pragma modifierFunctions

	gl_FragColor = color;
}