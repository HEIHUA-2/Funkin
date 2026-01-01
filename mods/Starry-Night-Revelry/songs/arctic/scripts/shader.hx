var saturation:CustomShader = new CustomShader('saturation');
saturation.saturation = 1.075;
saturation.offset = 0.475;
saturation.multiply = 2.5;
saturation.luminance_contrast = 0.7;
FlxG.camera.addShader(saturation);

event.createStep(832, () -> {
	FlxTween.num(saturation.saturation, 1, 4, {ease: FlxEase.quartIn}, (val:Float) -> {
		saturation.saturation = val;
	});
	FlxTween.num(saturation.multiply, 1, 4, {ease: FlxEase.quartIn}, (val:Float) -> {
		saturation.multiply = val;
	});
	FlxTween.num(saturation.luminance_contrast, 1, 4, {}, (val:Float) -> {
		saturation.luminance_contrast = val;
	});
});

event.createStep(1088, () -> {
	FlxTween.num(saturation.saturation, 1.075, 2, {}, (val:Float) -> {
		saturation.saturation = val;
	});
	FlxTween.num(saturation.multiply, 2.5, 2, {}, (val:Float) -> {
		saturation.multiply = val;
	});
	FlxTween.num(saturation.luminance_contrast, 0.7, 2, {ease: FlxEase.quartOut}, (val:Float) -> {
		saturation.luminance_contrast = val;
	});
});

__script__.didLoad = __script__.active = false;