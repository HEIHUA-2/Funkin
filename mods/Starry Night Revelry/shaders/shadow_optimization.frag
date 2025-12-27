#pragma header

// by HeiHua

uniform float offsetX;
uniform float offsetY;
uniform float QUALITY;

void main() {
    float stepQ = 1.0 / QUALITY;
    vec2 uvOffset = vec2(offsetX, offsetY) / openfl_TextureSize;
    vec2 delta = uvOffset * stepQ;
    vec2 currentOffset = delta;
    float colorA = 0.0;
    
    for (int j = 0; j < int(QUALITY); j++) {
        colorA += texture2D(bitmap, openfl_TextureCoordv + currentOffset).a;
        currentOffset += delta;
    }
    
    colorA += texture2D(bitmap, openfl_TextureCoordv).a;
    colorA = min(colorA, 1.0);
    
    gl_FragColor = vec4(vec3(0.0), colorA) * openfl_Alphav;
}