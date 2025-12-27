var cam = true;
var nnn = 0;

var colorShader:CustomShader;
var colorShader1:CustomShader;

static var colors3:FunkinSprite;
function onPostStartCountdown() {
	introSprites = [null];
	introSounds = [null];
	Conductor.songPosition = 0;
}


function postCreate() {
	setDadHitHealth(0.01, 0.00333333333333333333, 0);
	colors3=new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xffffffff);
	colors3.scale.set(1280 + 200, 720 + 200);
	colors3.updateHitbox();
	colors3.scrollFactor.set();
	colors3.zoomFactor = 0;
	colors3.alpha = 0;
	insert(members.indexOf(dad), colors3);
	add(colors3);

	colors2.alpha = 1;
	FlxG.camera.followLerp = 114514;
}


function onStartSong() {
	cinematicBars(100, -1);
	FlxTween.num(0.9, 1.5, sectionCrochet * 2, {ease:FlxEase.sineIn}, (val:Float) -> {
		FlxG.camera.zoom = val;
	});
	FlxTween.num(1, 0, sectionCrochet, {ease:FlxEase.sineOut}, (val:Float) -> {
		colors2.alpha = val;
	});
	//skipSongPosition(90);
}


function postUpdate(elapsed:Float) {
	if (cam) {
		FlxG.camera.scroll.set(camFollow.x - w, camFollow.y - h);
	}
}


function stepHit(step:Int) {
	switch (step) {
	case 32:
		cam = false;
		camZoomingInterval = 1;
		cinematicBars(0, 1);
		defaultCamZoom = 0.8;
		FlxG.camera.followLerp = 0.04;
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
		FlxTween.num(defaultCamZoom, 1.2, sectionCrochet * 2 - 0.035, {ease:FlxEase.sineInOut}, (val:Float) -> {
			defaultCamZoom = val;
		});
	case 128:
		setCamFollowMoment(450, 300);
		setCamZoomMoment(0.6);
	case 132:
		setCamZoomMoment(0.65);
	case 136:
		setCamZoomMoment(0.7);
	case 142:
		setCamZoomMoment(0.75);
	case 146:
		setCamZoomMoment(0.8);
	case 160:
		camZoomingInterval = 2;
		defaultCamZoom += 0.1;
		camFollowChars = true;
	case 184:
		FlxTween.num(defaultCamZoom, 1.5, sectionCrochet / 2 - 0.035, {ease:FlxEase.sineOut}, (val:Float) -> {
			defaultCamZoom = val;
		});
		FlxTween.num(0, 1, sectionCrochet * 0.37, {}, (val:Float) -> {
			colors2.alpha = val;
		});
		camOffset[0] = 60;
		camOffset[1] = 60;
	case 192:
		camZoomingInterval = 1;
		colors2.alpha = 0;
		colors1.alpha = 1;
		FlxTween.tween(colors1, {alpha: 0}, 1);
		camOffset[0] = 0;
		camOffset[1] = 0;
		setCamZoomMoment(0.9);
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
		FlxTween.num(0, 1, sectionCrochet / 4 - 0.035, {}, (val:Float) -> {
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
		FlxTween.num(0, 1.5, sectionCrochet / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 352:
		vcrshader.amount = 0;
		defaultCamZoom -= 0.3;
	case 356:
		defaultCamZoom += 0.2;
		vcrshader.amount = 1.5;
	case 360:
		FlxTween.num(1.5, 0.25, sectionCrochet / 4 - 0.035, {}, (val:Float) -> {
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
		FlxTween.num(defaultCamZoom, 1.25, sectionCrochet / 2 - 0.035, {ease:FlxEase.sineIn}, (val:Float) -> {
			defaultCamZoom = val;
		});
	case 376:
		FlxTween.num(1, 5, sectionCrochet / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 380:
		camZoomingInterval = 114514;
	case 385|390|396|400|406|412|416|422:
		addCameraZoom(0.015, 0.03);
	case 384:
		defaultCamZoom = 0.9;
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
		colors1.alpha=1;
		FlxTween.tween(colors1, {alpha: 0}, 1);
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
		FlxTween.num(1, 0.25, sectionCrochet / 8 - 0.035, {}, (val:Float) -> {
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
		FlxTween.num(1, 0.5, sectionCrochet / 8 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 620:
		defaultCamZoom += 0.2;
		FlxTween.num(1, 2, sectionCrochet / 8 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 622:
		defaultCamZoom -= 0.3;
		vcrshader.amount = 0;
	case 628:
		FlxTween.num(defaultCamZoom, 1.25, sectionCrochet * 0.75 - 0.035, {ease:FlxEase.sineIn}, (val:Float) -> {
			defaultCamZoom = val;
		});
		FlxTween.num(1, 2.5, sectionCrochet / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 640:
		vcrshader.amount = 0;
		setCamZoomMoment(0.9);
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
		FlxTween.num(0, 1, sectionCrochet / 4 - 0.035, {ease:FlxEase.sineOut}, (val:Float) -> {
			colors2.alpha = val;
		});
	case 702:
		vcrshader.amount = 0;
	case 704:
		camZoomingInterval = 114514;
		vcrshader.amount = 0.1;
		colors2.alpha=0;
		colors1.alpha=1;
		FlxTween.tween(colors1, {alpha: 0}, 1);
		setCamZoomMoment(1);
		for(stage in stage.stageSprites) FlxTween.color(stage, 0.001, stage.color, 0xff000000);
	case 768:
		vcrshader.amount = 0.15;
	case 808:
		vcrshader.amount = 0.2;
	case 824:
		FlxTween.num(0.25, 5, sectionCrochet * 8 - 0.035, {ease:FlxEase.quintIn}, (val:Float) -> {
			vcrshader.amount = val;
		});
		FlxTween.num(defaultCamZoom, 1.5, sectionCrochet * 8 - 0.035, {ease:FlxEase.quintIn}, (val:Float) -> {
			defaultCamZoom = val;
		});
	case 832:
		addCameraZoom(0.015, 0.03);
		camOffset[0] = -75;
	case 960:
		camOffset[0] = 0;
		camZoomingInterval = 1;
		setCamZoomMoment(0.9);
		vcrshader.amount = 0;
		colors1.alpha=1;
		FlxTween.tween(colors1, {alpha: 0}, 1);
		for(n => stage in stage.stageSprites)
			if (n != 'Lake_Surface' && n != 'Mountain' && n != 'Snow')
				FlxTween.color(stage, 0.001, stage.color, 0xffffffff);
			else
				FlxTween.color(stage, 0.001, stage.color, 0xffafafaf);
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
		FlxTween.num(0, 4, sectionCrochet * 8 - 0.035, {ease:FlxEase.sineIn}, (val:Float) -> {
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
		colors1.alpha = 1;
		FlxTween.tween(colors1, {alpha: 0}, 1);
		vcrshader.amount = 0;
		camZoomingInterval = 114514;
		nnn = 0;

		colorShader = new CustomShader('color');
		colorShader.a = 1;
			if (FlxG.save.data.starry_texture_shader) boyfriend.shader = colorShader;

		colorShader1 = new CustomShader('color');
		colorShader1.a = 1;
			if (FlxG.save.data.starry_texture_shader) dad.shader = colorShader1;

		colorShader.c = colorRGBFloat(boyfriend.iconColor);
		colorShader1.c = colorRGBFloat(dad.iconColor);

		for(stage in [fog, fog1, fog2]) stage.visible = false;
		for(stage in stage.stageSprites) FlxTween.color(stage, 0.001, stage.color, 0xff000000);
	case 1280:
		colors.alpha = 0;
		setCamZoomMoment(0.5);
		FlxTween.num(defaultCamZoom, 1.5, sectionCrochet * 16 - 0.035, {ease:FlxEase.quintIn}, (val:Float) -> {
			defaultCamZoom = val;
		});
	case 1440:
		FlxTween.num(0, 3, sectionCrochet * 2 - 0.035, {ease:FlxEase.sineIn}, (val:Float) -> {
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
		FlxTween.num(0.5, 3, sectionCrochet * 1.5 - 0.035, {ease:FlxEase.quintIn}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 1536:
		FlxTween.num(defaultCamZoom, 0.9, sectionCrochet * 2 - 0.035, {}, (val:Float) -> {
			defaultCamZoom = val;
		});
		FlxTween.num(3, 0, sectionCrochet * 2 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
		boyfriend.shader = null;
		dad.shader = null;
		for(n => stage in stage.stageSprites)
			if (n != 'Lake_Surface' && n != 'Mountain' && n != 'Snow')
				FlxTween.color(stage, 0.001, stage.color, 0xffffffff);
			else
				FlxTween.color(stage, 0.001, stage.color, 0xffafafaf);
		for(stage in [fog, fog1, fog2]) stage.visible = true;
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
	case 1802:
		defaultCamZoom += 0.1;
	case 1806|1810:
		defaultCamZoom += 0.05;
	case 1792+32:
		defaultCamZoom = 0.9;
	case 1802+32:
		defaultCamZoom += 0.1;
	case 1806+32|1810+32:
		defaultCamZoom += 0.05;
	case 1856:
		defaultCamZoom = 1.1;
	case 1860:
		defaultCamZoom += 0.05;
	case 1864|1872:
		defaultCamZoom -= 0.05;
	case 1878:
		defaultCamZoom += 0.05;
	case 1884:
		defaultCamZoom -= 0.05;
	case 1888:
		FlxTween.num(0, 3, sectionCrochet * 2 - 0.035, {}, (val:Float) -> {
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
	FlxTween.num(0, 1, sectionCrochet / 4, {}, (val:Float) -> {
		colors2.alpha = val;
	});
	}
	if (step % 4 == 0 && nnn != 0)
		FlxTween.num(nnn, nnn * 0.25, sectionCrochet / 4 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	if (step % 32 == 0 && step >= 1280 && step < 1536)
		FlxTween.num(0.15, 0, sectionCrochet - 0.035, {}, (val:Float) -> {
			colors3.alpha = val;
		});
}