var cam = true;
var nnn = 0;

var colorShader:CustomShader;
var colorShader1:CustomShader;

var colors:FunkinSprite;
var colors2:FunkinSprite;
var colors3:FunkinSprite;
var colors9:FunkinSprite;

public var vcrshader:CustomShader;
public var saturation:CustomShader;

function onPostStartCountdown() {
	introSprites = [null];
	introSounds = [null];
	Conductor.songPosition = 0;
}


function postCreate() {
	vcrshader = shaderQuality('vcr', [FlxG.game]);
	vcrshader.amount = 0;

	saturation = new CustomShader('saturation');
	saturation.saturation = 1.175;
	saturation.offset = 0.55;
	saturation.multiply = 2;
	saturation.luminance_contrast = 1;
	FlxG.camera.addShader(saturation);

	colors = new FunkinSprite().makeGraphic(1, 1, 0xff000000);
	colors.scale.set(1280, 720);
	colors.updateHitbox();
	colors.cameras = [camBar];
	colors.scrollFactor.set();
	colors.zoomFactor = 0;
	colors.alpha = 0;
	add(colors);

	colors2 = new FunkinSprite().makeGraphic(1, 1, 0xff000000);
	colors2.scale.set(1280, 720);
	colors2.updateHitbox();
	colors2.scrollFactor.set();
	colors2.zoomFactor = 0;
	colors2.alpha = 0;
	colors2.cameras = [camOther];
	add(colors2);

	setDadHitHealth(0.01, 0.00333333333333333333, 0);
	colors3 = new FunkinSprite(0, 0, Paths.image('stages/colorCorner'));
	colors3.scale.set(40, 40);
	colors3.updateHitbox();
	colors3.scrollFactor.set();
	colors3.zoomFactor = 0;
	colors3.alpha = 0;
	colors3.antialiasing = true;
	insert(members.indexOf(dad), colors3);
	add(colors3);

	colors9 = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xffffffff);
	colors9.scale.set(1280 + 200, 720 + 200);
	colors9.updateHitbox();
	colors9.scrollFactor.set();
	colors9.zoomFactor = 0;
	colors9.alpha = 0;
	insert(members.indexOf(dad), colors9);
	add(colors9);

	colors2.alpha = 1;
	
	defaultCamZoom -= 0.05;
}


function onStartSong() {
	cinematicBars(100, -1);
	FlxTween.num(0.9, 1.5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2, {ease:FlxEase.sineIn}, (val:Float) -> {
		FlxG.camera.zoom = val;
	});
	FlxTween.num(1, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease:FlxEase.sineOut}, (val:Float) -> {
		colors2.alpha = val;
	});
}


function postUpdate(elapsed:Float) {
	if (cam) {
		FlxG.camera.scroll.set(camFollow.x - FlxG.width / 2, camFollow.y - FlxG.height / 2);
	}
	vcrshader.iTime = FlxG.game.ticks * 0.001;
}


function stepHit(step:Int) {
	switch (step) {
	case 32:
		cam = false;
		camZoomingInterval = 1;
		cinematicBars(0, 1);
		defaultCamZoom = 0.8;
		defaultCamZoom -= 0.05;
	case 42:
		defaultCamZoom += 0.05;
	case 50:
		defaultCamZoom -= 0.05;
	case 60:
		defaultCamZoom += 0.05;
	case 42+32:
		defaultCamZoom += 0.05;
	case 50+32:
		defaultCamZoom -= 0.05;
	case 60+32:
		defaultCamZoom += 0.05;
	case 96:
		FlxTween.num(defaultCamZoom, 1.2, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2 - 0.035, {ease:FlxEase.sineInOut}, (val:Float) -> {
			defaultCamZoom = val;
			defaultCamZoom -= 0.05;
		});
	case 128:
		setCamFollowMoment(450, 300);
		setCamZoomMoment(0.6 - 0.05);
	case 132:
		setCamZoomMoment(0.65 - 0.05);
	case 136:
		setCamZoomMoment(0.7 - 0.05);
	case 142:
		setCamZoomMoment(0.75 - 0.05);
	case 146:
		setCamZoomMoment(0.8 - 0.05);
	case 160:
		camZoomingInterval = 2;
		defaultCamZoom += 0.1;
		camData.followChars = true;
	case 184:
		FlxTween.num(defaultCamZoom, 1.5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2 - 0.035, {ease:FlxEase.sineOut}, (val:Float) -> {
			defaultCamZoom = val;
			defaultCamZoom -= 0.05;
		});
		FlxTween.num(0, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 0.37, {}, (val:Float) -> {
			colors2.alpha = val;
		});
		camData.offset.x = 60;
		camData.offset.y = 60;
	case 192:
		camZoomingInterval = 1;
		colors2.alpha = 0;
		flash(1, 0xffffffff, camBar, 1, 0);
		camData.offset.x = 0;
		camData.offset.y = 0;
		setCamZoomMoment(0.9 - 0.05);
	case 200:
		defaultCamZoom += 0.05;
	case 208:
		defaultCamZoom += 0.05;
	case 216:
		defaultCamZoom -= 0.05;
	case 224:
		defaultCamZoom += 0.05;
	case 232:
		defaultCamZoom -= 0.05;
	case 240:
		defaultCamZoom -= 0.05;
	case 248:
		defaultCamZoom += 0.05;
	case 252:
		defaultCamZoom += 0.05;
	case 200+64:
		defaultCamZoom += 0.05;
	case 208+64:
		defaultCamZoom += 0.05;
	case 216+64:
		defaultCamZoom -= 0.05;
	case 224+64:
		defaultCamZoom += 0.05;
	case 232+64:
		defaultCamZoom -= 0.05;
	case 240+64:
		defaultCamZoom -= 0.05;
	case 248+64:
		defaultCamZoom += 0.05;
	case 252+64:
		defaultCamZoom += 0.05;
	case 320:
		defaultCamZoom -= 0.1;
	case 332:
		defaultCamZoom += 0.2;
		FlxTween.num(0, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 334:
		defaultCamZoom += 0.1;
	case 336:
		vcrshader.amount = 0;
		defaultCamZoom -= 0.3;
	case 340:
		defaultCamZoom += 0.2;
		vcrshader.amount = 1;
	case 342:
		defaultCamZoom -= 0.2;
		vcrshader.amount = 0.25;
	case 344:
		defaultCamZoom += 0.1;
	case 348:
		defaultCamZoom += 0.2;
		FlxTween.num(0, 1.5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 352:
		vcrshader.amount = 0;
		defaultCamZoom -= 0.3;
	case 356:
		defaultCamZoom += 0.2;
		vcrshader.amount = 1.5;
	case 360:
		FlxTween.num(1.5, 0.25, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 365:
		vcrshader.amount = 1;
		defaultCamZoom += 0.4;
	case 366:
		vcrshader.amount = 0;
		defaultCamZoom -= 0.4;
	case 372:
		vcrshader.amount = 1;
		FlxTween.num(defaultCamZoom, 1.25, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2 - 0.035, {ease:FlxEase.sineIn}, (val:Float) -> {
			defaultCamZoom = val;
			defaultCamZoom -= 0.05;
		});
	case 376:
		FlxTween.num(1, 5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 380:
		camZoomingInterval = 114514;
	case 385|390|396|400|406|412|416|422:
		addCameraZoom(0.015, 0.03);
	case 384:
		defaultCamZoom = 0.9;
		defaultCamZoom -= 0.05;
		vcrshader.amount = 0;
	case 396:
		defaultCamZoom += 0.05;
	case 400:
		defaultCamZoom -= 0.05;
	case 416:
		defaultCamZoom += 0.1;
	case 427:
		camZoomingInterval = 1;
	case 432:
		defaultCamZoom -= 0.05;
	case 436|440:
		defaultCamZoom += 0.05;
	case 444:
		defaultCamZoom -= 0.05;
	case 448:
		defaultCamZoom = 0.9;
		flash(1, 0xffffffff, camBar, 1, 0);
	case 462:
		defaultCamZoom += 0.1;
	case 470:
		defaultCamZoom -= 0.2;
	case 478:
		defaultCamZoom += 0.1;
	case 486:
		defaultCamZoom += 0.05;
	case 494:
		defaultCamZoom -= 0.05;
	case 498:
		defaultCamZoom -= 0.05;
	case 504:
		defaultCamZoom += 0.05;
	case 508:
		defaultCamZoom += 0.05;
	case 462+64:
		defaultCamZoom += 0.1;
	case 470+64:
		defaultCamZoom -= 0.1;
	case 478+64:
		defaultCamZoom += 0.1;
	case 486+64:
		defaultCamZoom += 0.05;
	case 494+64:
		defaultCamZoom -= 0.05;
	case 498+64:
		defaultCamZoom -= 0.05;
	case 504+64:
		defaultCamZoom += 0.05;
	case 508+64:
		defaultCamZoom += 0.05;
	case 576:
		defaultCamZoom -= 0.1;
	case 582:
		defaultCamZoom += 0.05;
	case 592:
		defaultCamZoom += 0.05;
	case 596:
		defaultCamZoom += 0.2;
		FlxTween.num(1, 0.25, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 8 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 598:
		defaultCamZoom -= 0.2;
	case 606:
		defaultCamZoom += 0.2;
		vcrshader.amount = 1;
	case 608:
		defaultCamZoom -= 0.2;
		vcrshader.amount = 0;
	case 612:
		defaultCamZoom += 0.1;
		FlxTween.num(1, 0.5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 8 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 620:
		defaultCamZoom += 0.2;
		FlxTween.num(1, 2, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 8 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 622:
		defaultCamZoom -= 0.3;
		vcrshader.amount = 0;
	case 628:
		FlxTween.num(defaultCamZoom, 1.25, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 0.75 - 0.035, {ease:FlxEase.sineIn}, (val:Float) -> {
			defaultCamZoom = val;
			defaultCamZoom -= 0.05;
		});
		FlxTween.num(1, 2.5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 640:
		vcrshader.amount = 0;
		setCamZoomMoment(0.9 - 0.05);
	case 660:
		defaultCamZoom += 0.1;
	case 676:
		defaultCamZoom -= 0.1;
	case 679:
		vcrshader.amount = 0.25;
	case 680:
		vcrshader.amount = 0;
	case 682:
		vcrshader.amount = 0.5;
		defaultCamZoom -= 0.2;
	case 684:
		vcrshader.amount = 1;
		defaultCamZoom += 0.2;
	case 688:
		vcrshader.amount = 0;
		defaultCamZoom -= 0.2;
	case 692:
		vcrshader.amount = 1;
		defaultCamZoom += 0.2;
	case 694:
		vcrshader.amount = 0;
		defaultCamZoom -= 0.2;
	case 696:
		vcrshader.amount = 0.5;
		defaultCamZoom += 0.1;
	case 700:
		vcrshader.amount = 5;
		defaultCamZoom -= 0.4;
		FlxTween.num(0, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4 - 0.035, {ease:FlxEase.sineOut}, (val:Float) -> {
			colors2.alpha = val;
		});
	case 702:
		vcrshader.amount = 0;
	case 704:
		camZoomingInterval = 114514;
		vcrshader.amount = 0.1;
		colors2.alpha=0;
		flash(1, 0xffffffff, camBar, 1, 0);
		setCamZoomMoment(1 - 0.05);
		for (n => stage in stage.stageSprites)
		{
			if (n != 'light') stage.color = 0xff000000;
		}
	case 768:
		vcrshader.amount = 0.15;
	case 808:
		vcrshader.amount = 0.2;
	case 824:
		FlxTween.num(0.25, 5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 8 - 0.035, {ease:FlxEase.quintIn}, (val:Float) -> {
			vcrshader.amount = val;
		});
		FlxTween.num(defaultCamZoom, 1.5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 8 - 0.035, {ease:FlxEase.quintIn}, (val:Float) -> {
			defaultCamZoom = val;
			defaultCamZoom -= 0.05;
		});
	case 832:
		addCameraZoom(0.015, 0.03);
		camData.offset.x = -75;
	case 960:
		camData.offset.x = 0;
		camZoomingInterval = 1;
		setCamZoomMoment(0.9 - 0.05);
		vcrshader.amount = 0;
		flash(1, 0xffffffff, camBar, 1, 0);
		for(n => stage in stage.stageSprites)
		{
			if (n != 'light') stage.color = 0xffafafaf;
		}

		stage.stageSprites['sky'].colorTransform.redMultiplier = 0.5;
		stage.stageSprites['sky'].colorTransform.greenMultiplier = 0.5;
		stage.stageSprites['sky'].colorTransform.blueMultiplier = 0.5;
		stage.stageSprites['sky'].colorTransform.redOffset = 50;
		stage.stageSprites['sky'].colorTransform.greenOffset = 50;
		stage.stageSprites['sky'].colorTransform.blueOffset = 50;
	case 968|976:
		defaultCamZoom += 0.05;
	case 992|1008:
		defaultCamZoom -= 0.05;
	case 1016|1020:
		defaultCamZoom += 0.05;
	case 1024:
		defaultCamZoom -= 0.1;
	case 1056|1060:
		defaultCamZoom += 0.05;
	case 1064:
		defaultCamZoom -= 0.1;
	case 1072|1076|1080|1084:
		defaultCamZoom += 0.05;
	case 1088:
		defaultCamZoom -= 0.2;
		FlxTween.num(0, 4, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 8 - 0.05, {ease:FlxEase.sineIn}, (val:Float) -> {
			nnn = val;
		});
	case 968+128|976+128:
		defaultCamZoom += 0.05;
	case 992+128|1008+128:
		defaultCamZoom -= 0.05;
	case 1016+128|1020+128:
		defaultCamZoom += 0.05;
	case 1024+128:
		defaultCamZoom -= 0.1;
	case 1056+128|1060+128:
		defaultCamZoom += 0.05;
	case 1064+128:
		defaultCamZoom -= 0.1;
	case 1072+128|1076+128|1080+128|1084+128:
		defaultCamZoom += 0.05;
	case 1216:
		colors.alpha = 1;
		flash(1, 0xffffffff, camBar, 1, 0);
		vcrshader.amount = 0;
		camZoomingInterval = 114514;
		nnn = 0;

		colorShader = new CustomShader('color');
		colorShader.a = 1;
		boyfriend.shader = colorShader;

		colorShader1 = new CustomShader('color');
		colorShader1.a = 1;
		dad.shader = colorShader1;

		colorShader.c = colorRGBFloat(boyfriend.iconColor);
		colorShader1.c = colorRGBFloat(dad.iconColor);

		// for(stage in [fog, fog2]) stage.visible = false;
		for (n => stage in stage.stageSprites)
		{
			if (n != 'light') stage.colorTransform.alphaMultiplier = 0;
		}
	case 1280:
		colors.alpha = 0;
		setCamZoomMoment(0.5);
		FlxTween.num(defaultCamZoom, 1.5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 16 - 0.035, {ease:FlxEase.quintIn}, (val:Float) -> {
			defaultCamZoom = val;
			defaultCamZoom -= 0.05;
		});
	case 1440:
		FlxTween.num(0, 3, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2 - 0.035, {ease:FlxEase.sineIn}, (val:Float) -> {
			nnn = val;
		});
	case 1472:
		vcrshader.amount = 0;
		nnn = 0;
	case 1492:
		vcrshader.amount = 1;
	case 1494:
		vcrshader.amount = 0;
	case 1498:
		vcrshader.amount = 0.5;
	case 1502:
		vcrshader.amount = 0.25;
	case 1508:
		vcrshader.amount = 1.5;
	case 1512:
		FlxTween.num(0.5, 3, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 1.5 - 0.035, {ease:FlxEase.quintIn}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 1536:
		FlxTween.num(defaultCamZoom, 0.9, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2 - 0.035, {}, (val:Float) -> {
			defaultCamZoom = val;
			defaultCamZoom -= 0.05;
		});
		FlxTween.num(3, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
		boyfriend.shader = null;
		dad.shader = null;
		for (n => stage in stage.stageSprites)
		{
			if (n != 'light') FlxTween.tween(stage.colorTransform, {alphaMultiplier: 1}, 1);
		}
		// for(stage in [fog, fog2]) stage.visible = true;
	case 1550|1554:
		defaultCamZoom += 0.05;
	case 1570:
		defaultCamZoom -= 0.1;
	case 1582|1586:
		defaultCamZoom += 0.05;
	case 1592:
		defaultCamZoom -= 0.1;
	case 1600:
		camZoomingInterval = 1;
	case 1550+64|1554+64:
		defaultCamZoom += 0.05;
	case 1570+64:
		defaultCamZoom -= 0.1;
	case 1582+64|1586+64:
		defaultCamZoom += 0.05;
	case 1592+64:
		defaultCamZoom -= 0.1;
	case 1684:
		defaultCamZoom += 0.05;
	case 1686:
		defaultCamZoom -= 0.05;
	case 1688|1692:
		defaultCamZoom += 0.05;
	case 1700:
		defaultCamZoom -= 0.1;
	case 1708|1716:
		defaultCamZoom += 0.05;
	case 1684+64:
		defaultCamZoom += 0.05;
	case 1686+64:
		defaultCamZoom -= 0.05;
	case 1688+64|1692+64:
		defaultCamZoom += 0.05;
	case 1700+64:
		defaultCamZoom -= 0.1;
	case 1708+64|1716+64:
		defaultCamZoom += 0.05;
	case 1792:
		defaultCamZoom = 0.9;
		defaultCamZoom -= 0.05;
	case 1802:
		defaultCamZoom += 0.1;
	case 1806|1810:
		defaultCamZoom += 0.05;
	case 1792+32:
		defaultCamZoom = 0.9;
		defaultCamZoom -= 0.05;
	case 1802+32:
		defaultCamZoom += 0.1;
	case 1806+32|1810+32:
		defaultCamZoom += 0.05;
	case 1856:
		defaultCamZoom = 1.1;
		defaultCamZoom -= 0.05;
	case 1860:
		defaultCamZoom += 0.05;
	case 1864|1872:
		defaultCamZoom -= 0.05;
	case 1878:
		defaultCamZoom += 0.05;
	case 1884:
		defaultCamZoom -= 0.05;
	case 1888:
		FlxTween.num(0, 3, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 1888|1892:
		defaultCamZoom += 0.05;
	case 1898:
		defaultCamZoom -= 0.05;
	case 1902|1906:
		defaultCamZoom += 0.05;
	case 1920:
		defaultCamZoom = 2;
		defaultCamZoom -= 0.05;
		FlxTween.num(0, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4, {}, (val:Float) -> {
			colors2.alpha = val;
		});
	}
	if (step % 4 == 0 && nnn != 0)
		FlxTween.num(nnn, nnn * 0.25, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	if (step % 32 == 0 && step >= 1280 && step < 1536)
		FlxTween.num(1, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 - 0.035, {}, (val:Float) -> {
			colors3.alpha = val * 0.2;
			colors9.alpha = val * 0.1;
		});
}