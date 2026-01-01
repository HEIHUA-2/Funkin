public var fog:FunkinSprite;
public var fog2:FunkinSprite;

function postCreate() {
	for(stage in stage.stageSprites) {
		stage.color = 0xFF776d91;
	}

	boyfriend.color = 0xFF776d91;
	dad.color = 0xFF776d91;

	fog = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xff000000);
	fog.scale.set(1280 + 200, 720 + 200);
	fog.updateHitbox();
	fog.scrollFactor.set();
	fog.zoomFactor = 0;
	fog.alpha = 0.2;
	insert(members.indexOf(stage.stageSprites['snow']), fog);

	fog2 = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xff000000);
	fog2.scale.set(1280 + 200, 720 + 200);
	fog2.updateHitbox();
	fog2.scrollFactor.set();
	fog2.zoomFactor = 0;
	fog2.alpha = 0.4;
	add(fog2);

	bfShadowAlpha = 0.1;
	dadShadowAlpha = 0.1;
}
// 优化神仙