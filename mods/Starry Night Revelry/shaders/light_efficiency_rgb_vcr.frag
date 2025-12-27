#pragma header

// by HeiHua

uniform float iTime;
uniform float amount;
uniform float brightness;
uniform float liang;

float hash(float v) {
    return fract(sin(v * 12.9898) * 43758.5453);
}

float hash(in vec2 _v) {
    return fract(sin(dot(_v, vec2(89.44, 19.36))) * 22189.22);
}

float optimizedNoise(vec2 uv) {
    vec2 f = floor(uv);
    return hash(f * 0.5) + hash(f + 1.0);
}

void main() {
    vec2 uv = openfl_TextureCoordv;
    float bright = max(brightness - uv.y - 0.5, 1.0) * liang;

    float timeFactor = iTime * 2.0;
    float yCoord = uv.y * 50.0;
    
    float offset = 0.0;
    if (amount > 0.0) {
        float noiseVal = hash(yCoord + timeFactor * 10.0) * 2.0 - 1.5;
        noiseVal += optimizedNoise(vec2(yCoord * 2.0, timeFactor * 30.0)) * 2.0 - 1.5;
        noiseVal += optimizedNoise(vec2(yCoord / 2.0 - 1.0, - timeFactor * 30.0)) * 2.0 - 1.5;
        offset = noiseVal * 0.005 * amount;
    }

    vec3 color;
    vec2 baseUV = uv + vec2(offset, 0.0);
    color.r = texture2D(bitmap, baseUV + vec2(0.0, offset * 0.3)).r;
    color.g = texture2D(bitmap, baseUV).g;
    color.b = texture2D(bitmap, baseUV - vec2(0.0, offset * 0.3)).b;

    // color -= 0.12 * smoothstep(0.1, 0.3, abs(offset) * 50.0);
    
    gl_FragColor = vec4(color * bright, 1.0);
}