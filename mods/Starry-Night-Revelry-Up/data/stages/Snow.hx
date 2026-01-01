public var bfShadow:FunkinSprite;
public var dadShadow:FunkinSprite;

public var bfShadowAlpha = 0.3;
public var dadShadowAlpha = 0.3;

public var shadow_optimization_bf:CustomShader;
public var shadow_optimization_dad:CustomShader;

function create() {
	for(stage in stage.stageSprites) {
		stage.color = 0xfffefefe;
	}

	boyfriend.color = 0xfffefefe;
	dad.color = 0xfffefefe;
}

function postCreate() {
	bfShadow = FunkinSprite.copyFrom(boyfriend);
	bfShadow.flipY = !boyfriend.flipY;
	bfShadow.color = 0x00000000;
	insert(members.indexOf(dad), bfShadow);
	bfShadow.skew.x = 17000 / boyfriend.height;

	shadow_optimization_bf = new CustomShader('shadow_optimization');
	shadow_optimization_bf.offsetY = -45;
	shadow_optimization_bf.QUALITY = 15;
	bfShadow.shader = shadow_optimization_bf;

	dadShadow = FunkinSprite.copyFrom(dad);
	dadShadow.flipY = !dad.flipY;
	dadShadow.color = 0x00000000;
	insert(members.indexOf(dad), dadShadow);
	dadShadow.skew.x = 10000 / dad.height;

	shadow_optimization_dad = new CustomShader('shadow_optimization');
	shadow_optimization_dad.offsetY = -30;
	shadow_optimization_dad.QUALITY = 8;
	dadShadow.shader = shadow_optimization_dad;

	maxCamZoom = 2;
}

function postUpdate(elapsed:Float) {
	bfShadow.alpha = boyfriend.alpha * bfShadowAlpha;
	bfShadow.setPosition(boyfriend.x + 67.5, boyfriend.y + 350);
	bfShadow.frameOffset.set(boyfriend.frameOffset.x, boyfriend.frameHeight - boyfriend.frameOffset.y - 780);
	bfShadow.offset = boyfriend.offset;
	bfShadow.animation.frameName = boyfriend.animation.frameName;

	dadShadow.alpha = dad.alpha * dadShadowAlpha;
	dadShadow.setPosition(dad.x - 27.5, dad.y - 70);
	dadShadow.frameOffset.set(dad.frameOffset.x, dad.frameHeight - dad.frameOffset.y - 825);
	dadShadow.offset = dad.offset;
	dadShadow.animation.frameName = dad.animation.frameName;
}