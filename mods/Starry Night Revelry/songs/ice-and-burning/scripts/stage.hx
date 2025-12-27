import flixel.math.FlxMath;
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
	for (obj in [stage.stageSprites['Lake_Surface'], stage.stageSprites['Mountain'], stage.stageSprites['Snow'], boyfriend, dad]) obj.color = 0xFF4A5568;
	comboGroupColor = 0xFF4A5568;


	fog = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xff000000);
	fog.scale.set(1280 + 200, 720 + 200);
	fog.updateHitbox();
	fog.scrollFactor.set();
	fog.zoomFactor = 0;
	fog.alpha = 0.2;
	insert(members.indexOf(stage.stageSprites['Snow']), fog);
	add(fog);

	fog1 = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xFF4A5568);
	fog1.scale.set(1280 + 200, 720 + 200);
	fog1.updateHitbox();
	fog1.scrollFactor.set();
	fog1.zoomFactor = 0;
	fog1.alpha = 0.5;
	insert(members.indexOf(stage.stageSprites['Mountain']), fog1);
	add(fog1);

	fog2 = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xff000000);
	fog2.scale.set(1280 + 200, 720 + 200);
	fog2.updateHitbox();
	fog2.scrollFactor.set();
	fog2.zoomFactor = 0;
	fog2.alpha = 0.1;
	add(fog2);


	mistFront=new FlxBackdrop(Paths.image('stages/mistFront'), 0x01, 0);
	mistFront.setPosition(0, -400);
	mistFront.scale.set(4, 4);
	mistFront.updateHitbox();
	mistFront.velocity.set(75, 0);
	mistFront.scrollFactor.set(0.75, 0.75);
	mistFront.blend = BlendMode.ADD;
	mistFront.antialiasing = true;
	mistFront.alpha = 0.4;
	mistFront.color = 0xFF4A5568;
	// insert(members.indexOf(stage.stageSprites['Snow']), mistFront);
	// add(mistFront);

	mistFront2=new FlxBackdrop(Paths.image('stages/mistFront'), 0x01, 0);
	mistFront2.setPosition(0, -600);
	mistFront2.scale.set(3, 4);
	mistFront2.updateHitbox();
	mistFront2.velocity.set(30, 0);
	mistFront2.scrollFactor.set(0.5, 0.5);
	mistFront2.blend = BlendMode.ADD;
	mistFront2.antialiasing = true;
	mistFront2.alpha = 0.4;
	mistFront2.color = 0xFF4A5568;
	// insert(members.indexOf(stage.stageSprites['Snow']), mistFront2);
	// add(mistFront2);
	
	mistFront3=new FlxBackdrop(Paths.image('stages/mistFront'), 0x01, 0);
	mistFront3.setPosition(0, 0);
	mistFront3.scale.set(5, 4);
	mistFront3.updateHitbox();
	mistFront3.velocity.set(10, 0);
	mistFront3.scrollFactor.set(0.25, 0.25);
	mistFront3.blend = BlendMode.ADD;
	mistFront3.antialiasing = true;
	mistFront3.alpha = 0.4;
	mistFront3.color = 0xFF4A5568;
	// insert(members.indexOf(stage.stageSprites['Snow']), mistFront3);
	// add(mistFront3);


	bfShadowAlpha = 0.1;
	dadShadowAlpha = 0.1;
}
// 优化神仙