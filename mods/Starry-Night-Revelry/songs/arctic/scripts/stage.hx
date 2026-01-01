var fog:FunkinSprite = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xffffffff);

event.createStep(832, () -> {
	FlxTween.num(fog.alpha, 0, 4, {}, (val:Float) -> {
		fog.alpha = val;
	});
});

event.createStep(1088, () -> {
	FlxTween.num(fog.alpha, 0.075, 4, {}, (val:Float) -> {
		fog.alpha = val;
	});
});

function postCreate() {
	fog.scale.set(1280 + 200, 720 + 200);
	fog.updateHitbox();
	fog.scrollFactor.set();
	fog.zoomFactor = 0;
	fog.alpha = 0.075;
	add(fog);

	__script__.didLoad = __script__.active = false;
}