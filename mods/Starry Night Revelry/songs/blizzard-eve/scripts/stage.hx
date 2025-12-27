import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.addons.display.FlxBackdrop;
import openfl.display.BlendMode;

static var fog:FunkinSprite;
static var fog1:FunkinSprite;
static var fog2:FunkinSprite;

static var mistFront:FlxBackdrop;
static var mistFront2:FlxBackdrop;
static var mistFront3:FlxBackdrop;

function postCreate() {
	for (obj in [stage.stageSprites['sky'], stage.stageSprites['Sun'], stage.stageSprites['Light_2'], stage.stageSprites['Sunlight']]) obj.destroy();
	for (obj in [stage.stageSprites['Lake_Surface'], stage.stageSprites['Mountain'], stage.stageSprites['Snow'], boyfriend, dad]) obj.color = 0xffafafaf;
	comboGroupColor = 0xffd2d2d2;


	fog=new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xffffffff);
	fog.scale.set(1280+200, 720+200);
	fog.updateHitbox();
	fog.scrollFactor.set();
	fog.zoomFactor = 0;
	fog.alpha = 0.2;
	insert(members.indexOf(stage.stageSprites['Snow']), fog);
	add(fog);

	fog1=new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xffa5a5a5);
	fog1.scale.set(1280+200, 720+200);
	fog1.updateHitbox();
	fog1.scrollFactor.set();
	fog1.zoomFactor = 0;
	fog1.alpha = 0.95;
	insert(members.indexOf(stage.stageSprites['Mountain']), fog1);
	add(fog1);

	fog2=new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xffffffff);
	fog2.scale.set(1280+200, 720+200);
	fog2.updateHitbox();
	fog2.scrollFactor.set();
	fog2.zoomFactor = 0;
	fog2.alpha = 0.1;
	add(fog2);

	mistFront=new FlxBackdrop(Paths.image('stages/mistFront'), 0x01, 0);
	mistFront.setPosition(0, -400);
	mistFront.scale.set(4, 4);
	mistFront.updateHitbox();
	mistFront.velocity.set(50, 0);
	mistFront.scrollFactor.set(1, 1);
	mistFront.blend = BlendMode.ADD;
	mistFront.antialiasing = true;
	mistFront.alpha = 0.2;
	// add(mistFront);

	mistFront2=new FlxBackdrop(Paths.image('stages/mistFront'), 0x01, 0);
	mistFront2.setPosition(0, -600);
	mistFront2.scale.set(3, 4);
	mistFront2.updateHitbox();
	mistFront2.velocity.set(100, 0);
	mistFront2.scrollFactor.set(1.25, 1.25);
	mistFront2.blend = BlendMode.ADD;
	mistFront2.antialiasing = true;
	mistFront2.alpha = 0.175;
	// add(mistFront2);
	
	mistFront3=new FlxBackdrop(Paths.image('stages/mistFront'), 0x01, 0);
	mistFront3.setPosition(0, 0);
	mistFront3.scale.set(5, 4);
	mistFront3.updateHitbox();
	mistFront3.velocity.set(200, 0);
	mistFront3.scrollFactor.set(1.5, 1.5);
	mistFront3.blend = BlendMode.ADD;
	mistFront3.antialiasing = true;
	mistFront3.alpha = 0.15;
	// add(mistFront3);

	bfShadowAlpha = 0.15;
	dadShadowAlpha = 0.15;
}