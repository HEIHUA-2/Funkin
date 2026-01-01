import shaders.SnowShader;

var snow:CustomShader = new SnowShader();
snow.applyShader();
add(snow);

event.createStep(704, function() {
	snow.snowSpeed = 0.25;
});

event.createStep(960, function() {
	snow.snowSpeed = 1;
});

event.createStep(1280, function() {
	snow.snowSpeed = 0.25;
});

event.createStep(1536, function() {
	snow.snowSpeed = 1;
});