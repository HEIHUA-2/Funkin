#pragma header

// by HeiHua

uniform float iTime;
uniform float amount;


float hash(float v) {
    return fract(sin(v * 12.9898) * 43758.5453);
}

float hash(vec2 v) {
    vec2 k = vec2(0.3183099, 0.3678794);
    return fract(cos(dot(v, k)) * 43758.5453);
}

void main() {
    vec2 uv = openfl_TextureCoordv;
    
    float timeHash = hash(uv.y * 10.0 + iTime * 2.0) - 0.5;
    vec2 grid = vec2(uv.y * 50.0, iTime * 25.0);
    float patternHash = hash(floor(grid) * 0.5) - 0.5;
    
    float offset = (timeHash + patternHash) * 0.125 * amount;
    uv.x += offset * smoothstep(0.0, 1.0, abs(offset));
    
    vec3 color = texture2D(bitmap, uv).rgb * 0.9;
    
    gl_FragColor = vec4(color, 0.0039215686274);
}