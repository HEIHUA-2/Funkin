#pragma header

uniform float offsetX;
uniform float offsetY;
uniform float QUALITY;

varying vec3 v;

void main(void) {
  #pragma body

  v.xy = vec2(offsetX, offsetY) / openfl_TextureSize;
  v.z = 1.0 / QUALITY;
}