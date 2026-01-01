import flixel.addons.display.FlxBackdrop;

public var fog:FunkinSprite;
public var fog2:FunkinSprite;

public var fog_1:FlxBackdrop;
public var fog_2:FlxBackdrop;
public var fog_3:FlxBackdrop;

public var saturation:CustomShader;

function postCreate() {
	saturation = new CustomShader('saturation');
	saturation.saturation = 1.1;
	saturation.offset = 0.6;
	saturation.multiply = 1.75;
	saturation.luminance_contrast = 1;
	FlxG.camera.addShader(saturation);

	for(stage in stage.stageSprites) {
		stage.color = 0xffafafaf;
	}

	boyfriend.color = 0xffafafaf;
	dad.color = 0xffafafaf;

	fog = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xffc28663);
	fog.scale.set(1280 + 200, 720 + 200);
	fog.updateHitbox();
	fog.scrollFactor.set();
	fog.zoomFactor = 0;
	fog.alpha = 0.2;
	insert(members.indexOf(stage.stageSprites['snow']), fog);

	fog2 = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xff997a6d);
	fog2.scale.set(1280 + 200, 720 + 200);
	fog2.updateHitbox();
	fog2.scrollFactor.set();
	fog2.zoomFactor = 0;
	fog2.alpha = 0.1;
	add(fog2);

	fog_1 = new FlxBackdrop(Paths.image('stages/fog_1'), 0x01, 0);
	fog_1.setPosition(0, -200);
	fog_1.scale.set(5, 5);
	fog_1.updateHitbox();
	fog_1.scale.set(100, 100);
	fog_1.velocity.set(500, 0);
	fog_1.antialiasing = true;
	fog_1.alpha = 0.5;
	insert(members.indexOf(stage.stageSprites['snow']), fog_1);

	fog_2 = new FlxBackdrop(Paths.image('stages/fog_2'), 0x01, 0);
	fog_2.setPosition(0, -200);
	fog_2.scale.set(5, 5);
	fog_2.updateHitbox();
	fog_2.scale.set(100, 100);
	fog_2.velocity.set(250, 0);
	fog_2.antialiasing = true;
	fog_2.alpha = 0.5;
	insert(members.indexOf(stage.stageSprites['snow']), fog_2);

	fog_3 = new FlxBackdrop(Paths.image('stages/fog_3'), 0x01, 0);
	fog_3.setPosition(0, -200);
	fog_3.scale.set(5, 5);
	fog_3.updateHitbox();
	fog_3.scale.set(100, 100);
	fog_3.velocity.set(-250, 0);
	fog_3.antialiasing = true;
	fog_3.alpha = 0.2;
	add(fog_3);

	bfShadowAlpha = 0.1;
	dadShadowAlpha = 0.1;
}