import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxAxes;

public var fog:FunkinSprite;
public var fog2:FunkinSprite;

public var fog_1:FlxBackdrop;
public var fog_2:FlxBackdrop;
public var fog_3:FlxBackdrop;

function postCreate() {
	for(stage in stage.stageSprites) {
		stage.color = 0xffafafaf;
	}

	stage.stageSprites['sky'].colorTransform.redMultiplier = 0.5;
	stage.stageSprites['sky'].colorTransform.greenMultiplier = 0.5;
	stage.stageSprites['sky'].colorTransform.blueMultiplier = 0.5;
	stage.stageSprites['sky'].colorTransform.redOffset = 50;
	stage.stageSprites['sky'].colorTransform.greenOffset = 50;
	stage.stageSprites['sky'].colorTransform.blueOffset = 50;

	boyfriend.color = 0xffafafaf;
	dad.color = 0xffafafaf;

	fog_0 = new FlxBackdrop(Paths.image('stages/fog_3'), 0x01, 0);
	fog_0.setPosition(0, -300);
	fog_0.scale.set(3, 3);
	fog_0.velocity.set(-220, 0);
	fog_0.antialiasing = true;
	fog_0.alpha = 0.6;
	fog_0.colorTransform.redMultiplier = -0.5;
	fog_0.colorTransform.greenMultiplier = -0.5;
	fog_0.colorTransform.blueMultiplier = -0.5;
	fog_0.colorTransform.redOffset = 200;
	fog_0.colorTransform.greenOffset = 200;
	fog_0.colorTransform.blueOffset = 200;
	insert(members.indexOf(stage.stageSprites['snow']), fog_1);

	fog_1 = new FlxBackdrop(Paths.image('stages/fog_1'), 0x01, 0);
	fog_1.setPosition(0, -300);
	fog_1.scale.set(2.5, 2.5);
	fog_1.velocity.set(190, 0);
	fog_1.antialiasing = true;
	fog_1.alpha = 0.5;
	fog_1.colorTransform.redMultiplier = -0.5;
	fog_1.colorTransform.greenMultiplier = -0.5;
	fog_1.colorTransform.blueMultiplier = -0.5;
	fog_1.colorTransform.redOffset = 200;
	fog_1.colorTransform.greenOffset = 200;
	fog_1.colorTransform.blueOffset = 200;
	insert(members.indexOf(stage.stageSprites['snow']), fog_1);

	fog_2 = new FlxBackdrop(Paths.image('stages/fog_2'), 0x01, 0);
	fog_2.setPosition(0, -300);
	fog_2.scale.set(2.5, 32.5);
	fog_2.velocity.set(110, 0);
	fog_2.antialiasing = true;
	fog_2.alpha = 0.5;
	fog_2.colorTransform.redMultiplier = -0.5;
	fog_2.colorTransform.greenMultiplier = -0.5;
	fog_2.colorTransform.blueMultiplier = -0.5;
	fog_2.colorTransform.redOffset = 200;
	fog_2.colorTransform.greenOffset = 200;
	fog_2.colorTransform.blueOffset = 200;
	insert(members.indexOf(stage.stageSprites['snow']), fog_2);

	fog_3 = new FlxBackdrop(Paths.image('stages/fog_3'), 0x01, 0);
	fog_3.setPosition(0, -300);
	fog_3.scale.set(2.5, 2.5);
	fog_3.velocity.set(-120, 0);
	fog_3.antialiasing = true;
	fog_3.alpha = 0.25;
	fog_3.colorTransform.redMultiplier = -0.25;
	fog_3.colorTransform.greenMultiplier = -0.25;
	fog_3.colorTransform.blueMultiplier = -0.25;
	fog_3.colorTransform.redOffset = 200;
	fog_3.colorTransform.greenOffset = 200;
	fog_3.colorTransform.blueOffset = 200;
	add(fog_3);

	bfShadowAlpha = 0.1;
	dadShadowAlpha = 0.1;

	__script__.didLoad = __script__.active = false;
}