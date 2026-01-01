import shaders.SnowShader;

var snow:CustomShader = new SnowShader();
snow.applyShader();
snow.snowSpeed = 5;
add(snow);