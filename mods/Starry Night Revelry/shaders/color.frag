#pragma header

// by HeiHua

uniform float a;
uniform vec3 c;

void main() {
    vec4 base = texture2D(bitmap, openfl_TextureCoordv);
		base.rgb /= 1.0 - a;
    
    vec4 transformed = clamp(
        base * openfl_ColorMultiplierv * openfl_Alphav + openfl_ColorOffsetv,
        0.0, 
        1.0
    );

    float blendFactor = a * transformed.a;
    vec3 finalColor = mix(
        transformed.rgb * (1.0 - a), 
        c.rgb, 
        blendFactor
    );

    gl_FragColor = vec4(finalColor, transformed.a);
}