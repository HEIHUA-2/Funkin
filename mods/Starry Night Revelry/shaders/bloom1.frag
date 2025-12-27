#pragma header

// by HeiHua

uniform sampler2D openfl_Texture;

uniform float sigma;

vec3 textureMix(sampler2D bitmap, vec2 uv, float size)
{
    vec3 rgb = texture2D(bitmap, uv).rgb;
    rgb += texture2D(bitmap, uv + (vec2(-size)) / openfl_TextureSize).rgb;
    rgb += texture2D(bitmap, uv + (vec2(size, -size)) / openfl_TextureSize).rgb;
    rgb += texture2D(bitmap, uv + (vec2(-size, size)) / openfl_TextureSize).rgb;
    rgb += texture2D(bitmap, uv + (vec2(size)) / openfl_TextureSize).rgb;
    rgb += texture2D(bitmap, uv + (vec2(-size, 0.0)) / openfl_TextureSize).rgb;
    rgb += texture2D(bitmap, uv + (vec2(size, 0.0)) / openfl_TextureSize).rgb;
    rgb += texture2D(bitmap, uv + (vec2(0.0, -size)) / openfl_TextureSize).rgb;
    rgb += texture2D(bitmap, uv + (vec2(0.0, size)) / openfl_TextureSize).rgb;

    return rgb / 9.0;
}

void main() {
    vec2 blockCoord = floor(openfl_TextureCoordv * openfl_TextureSize / sigma) / openfl_TextureSize * sigma;

    vec3 rgb[4];
    rgb[0] = textureMix(openfl_Texture, blockCoord + (vec2(0.5, 0.5)) / openfl_TextureSize, sigma / 2.0);
    rgb[1] = textureMix(openfl_Texture, blockCoord + (vec2(0.5 + sigma, 0.5)) / openfl_TextureSize, sigma / 2.0);
    rgb[2] = textureMix(openfl_Texture, blockCoord + (vec2(0.5, 0.5 + sigma)) / openfl_TextureSize, sigma / 2.0);
    rgb[3] = textureMix(openfl_Texture, blockCoord + (vec2(0.5 + sigma, 0.5 + sigma)) / openfl_TextureSize, sigma / 2.0);

    // rgb[0] = texture2D(bitmap, blockCoord + (vec2(0.5, 0.5)) / openfl_TextureSize).rgb;
    // rgb[1] = texture2D(bitmap, blockCoord + (vec2(0.5 + sigma, 0.5)) / openfl_TextureSize).rgb;
    // rgb[2] = texture2D(bitmap, blockCoord + (vec2(0.5, 0.5 + sigma)) / openfl_TextureSize).rgb;
    // rgb[3] = texture2D(bitmap, blockCoord + (vec2(0.5 + sigma, 0.5 + sigma)) / openfl_TextureSize).rgb;


    vec2 fuv = (openfl_TextureCoordv * openfl_TextureSize - blockCoord * openfl_TextureSize) / sigma;

    vec3 col = texture2D(openfl_Texture, openfl_TextureCoordv).rgb;
    vec3 col2 = mix(
        mix(rgb[0], rgb[1], fuv.x),
        mix(rgb[2], rgb[3], fuv.x), fuv.y
    );

    vec3 color;
    if (length(col) > length(col2))
        color = col;
    else
        color = col * 0.7 + col2 * 0.3;
        

    gl_FragColor = vec4(color, 1.0);
}