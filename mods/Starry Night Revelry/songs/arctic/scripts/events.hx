import openfl.display.BlendMode;

static var colors3:FunkinSprite;

var colorShader:CustomShader;
var colorShader1:CustomShader;

function onPostStartCountdown() {
	introSprites = [null];
	introSounds = [null];
	Conductor.songPosition = 0;
}

function postCreate() {
	camHUD.alpha = 0;
	colors2.alpha = 1;

	colors3 = new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xffffffff);
	colors3.scale.set(1280 + 200, 720 + 200);
	colors3.updateHitbox();
	colors3.scrollFactor.set();
	colors3.zoomFactor = 0;
	colors3.alpha = 0;
	colors3.blend = BlendMode.ADD;
	insert(members.indexOf(dad), colors3);
	add(colors3);
}

function onStartSong() {
	colorShader = new CustomShader('color');
	colorShader.a = 0;
	if (FlxG.save.data.starry_texture_shader) boyfriend.shader = colorShader;

	colorShader1 = new CustomShader('color');
	colorShader1.a = 0;
	if (FlxG.save.data.starry_texture_shader) dad.shader = colorShader1;

	colorShader.c = colorRGBFloat(boyfriend.iconColor);
	colorShader1.c = colorRGBFloat(dad.iconColor);


	setCamFollowMoment(450, 250);
	cinematicBars(100, -1);
	FlxTween.num(0.9, 0.6, sectionCrochet * 3, {ease:FlxEase.sineInOut}, (val:Float) -> {
		FlxG.camera.zoom = val;
	});
	FlxTween.num(1, 0, sectionCrochet, {ease:FlxEase.sineOut}, (val:Float) -> {
		colors2.alpha = val;
	});
}

function stepHit(step:Int) {
	switch (step) {
	case 56:
		FlxTween.num(0, 1, sectionCrochet, {ease:FlxEase.sineOut}, (val:Float) -> {
			camHUD.alpha = val;
		});
	case 64:
		camFollowChars = true;
	case 114:
		defaultCamZoom += 0.05;
	case 128:
		defaultCamZoom -= 0.05;
	case 178:
		defaultCamZoom += 0.05;
	case 192:
		camOffset[1] = 25;
		defaultCamZoom += 0.05;
		camZoomingInterval = 2;
	case 216:
		defaultCamZoom -= 0.05;
	case 219:
		defaultCamZoom += 0.05;
	case 224:
		defaultCamZoom -= 0.05;
	case 228:
		defaultCamZoom += 0.05;
	case 230:
		defaultCamZoom -= 0.025;
	case 232:
		defaultCamZoom += 0.05;
	case 234:
		defaultCamZoom -= 0.025;
	case 235:
		defaultCamZoom += 0.05;
	case 238:
		defaultCamZoom -= 0.1;
	case 192+64:
		defaultCamZoom = 0.8;
	case 216+64:
		defaultCamZoom -= 0.05;
	case 219+64:
		defaultCamZoom += 0.05;
	case 224+64:
		defaultCamZoom -= 0.05;
	case 228+64:
		defaultCamZoom += 0.05;
	case 230+64:
		defaultCamZoom -= 0.025;
	case 232+64:
		defaultCamZoom += 0.05;
	case 234+64:
		defaultCamZoom -= 0.025;
	case 235+64:
		defaultCamZoom += 0.05;
	case 238+64:
		defaultCamZoom -= 0.1;
	case 306:
		defaultCamZoom += 0.05;
		for(stage in stage.stageSprites) {
			FlxTween.color(stage, 0.5, stage.color, 0xff646464);
		}
	case 320:
		for(stage in stage.stageSprites) {
			FlxTween.color(stage, 1.5, stage.color, 0xffc8c8c8);
		}
		defaultCamZoom = 0.7;
		cinematicBars(0, 2);
	case 328:
		defaultCamZoom += 0.05;
	case 336:
		defaultCamZoom -= 0.05;
	case 346|348|350:
		defaultCamZoom += 0.05;
	case 352:
		defaultCamZoom -= 0.1;
	case 360:
		defaultCamZoom += 0.1;
	case 366:
		defaultCamZoom += 0.05;
	case 368:
		defaultCamZoom -= 0.05;
	case 378|380|382:
		defaultCamZoom += 0.05;
	case 392:
		defaultCamZoom += 0.05;
	case 396|368:
		defaultCamZoom -= 0.05;
	case 402:
		defaultCamZoom -= 0.1;
	case 408:
		defaultCamZoom += 0.05;
	case 410:
		defaultCamZoom -= 0.025;
	case 412:
		defaultCamZoom += 0.05;
	case 414:
		defaultCamZoom -= 0.025;
	case 416:
		defaultCamZoom = 0.9;
	case 392+32:
		defaultCamZoom += 0.05;
	case 396+32|368+32:
		defaultCamZoom -= 0.05;
	case 402+32:
		defaultCamZoom -= 0.1;
	case 408+32:
		defaultCamZoom += 0.05;
	case 410+32:
		defaultCamZoom -= 0.025;
	case 412+32:
		defaultCamZoom += 0.05;
	case 414+32:
		defaultCamZoom -= 0.025;
	case 448:
		defaultCamZoom = 0.8;
	case 451|456:
		defaultCamZoom += 0.05;
	case 458:
		defaultCamZoom -= 0.025;
	case 460:
		defaultCamZoom += 0.05;
	case 462:
		defaultCamZoom -= 0.025;
	case 464|467:
		defaultCamZoom -= 0.05;
	case 472|476:
		defaultCamZoom += 0.075;
	case 480:
		defaultCamZoom -= 0.1;
	case 486:
		defaultCamZoom += 0.05;
	case 488:
		defaultCamZoom -= 0.075;
	case 492|494:
		defaultCamZoom += 0.05;
	case 496:
		defaultCamZoom -= 0.1;
	case 448+64:
		defaultCamZoom = 0.8;
	case 451+64|456+64:
		defaultCamZoom += 0.05;
	case 458+64:
		defaultCamZoom -= 0.025;
	case 460+64:
		defaultCamZoom += 0.05;
	case 462+64:
		defaultCamZoom -= 0.025;
	case 464+64|467+64:
		defaultCamZoom -= 0.05;
	case 472+64|476+64:
		defaultCamZoom += 0.075;
	case 480+64:
		defaultCamZoom -= 0.1;
	case 486+64:
		defaultCamZoom += 0.05;
	case 488+64:
		defaultCamZoom -= 0.075;
	case 492+64|494+64:
		defaultCamZoom += 0.05;
	case 496+64:
		defaultCamZoom -= 0.1;
	case 572:
		defaultCamZoom += 0.05;
	case 576:
		defaultCamZoom = 0.75;
	case 704:
		defaultCamZoom = 1;
	case 832:
		camZoomingInterval = 114514;
		defaultCamZoom = 0.5;
		setCamFollow(450, 350);
		for(stage in stage.stageSprites) {
			FlxTween.color(stage, 4, stage.color, 0xff000000);
		}
		FlxTween.num(defaultCamZoom, 0.7, sectionCrochet * 16, {}, (val:Float) -> {
			defaultCamZoom = val;
		});
		FlxTween.num(0, 1, 4, {}, (val:Float) -> {
			colorShader.a = val;
			colorShader1.a = val;
		});
		cinematicBars(100, 3);
	case 959:
		// camZoomingInterval = 2;
	case 1088:
		cinematicBars(0, 4);
		defaultCamZoom = 0.8;
		camFollowChars = true;
		colors1.alpha = 1;
		FlxTween.tween(colors1, {alpha: 0}, 1);

		FlxTween.num(1, 0, 2, {}, (val:Float) -> {
			colorShader.a = val;
			colorShader1.a = val;
		});
		for(n => stage in stage.stageSprites) {
			if (n != 'Lake_Surface' && n != 'Mountain' && n != 'Snow')
				FlxTween.color(stage, 2, stage.color, 0xffffffff);
			else
				FlxTween.color(stage, 2, stage.color, 0xffc8c8c8);
		}
	case 1096:
		defaultCamZoom = 0.9;
	case 1118:
		defaultCamZoom += 0.1;
	case 1122:
		defaultCamZoom -= 0.1;
	case 1134:
		defaultCamZoom += 0.1;
	case 1152:
		defaultCamZoom = 0.9;
	case 1118+64:
		defaultCamZoom += 0.1;
	case 1122+64:
		defaultCamZoom -= 0.1;
	case 1134+64:
		defaultCamZoom += 0.1;
	case 1216:
		defaultCamZoom -= 0.1;
	case 1222:
		defaultCamZoom += 0.1;
	case 1232:
		defaultCamZoom -= 0.1;
	case 1243:
		defaultCamZoom += 0.05;
	case 1248:
		defaultCamZoom -= 0.1;
	case 1256|1259|1262:
		defaultCamZoom += 0.05;
	case 1266:
		defaultCamZoom -= 0.1;
	case 1216+64:
		defaultCamZoom -= 0.1;
	case 1222+64:
		defaultCamZoom += 0.1;
	case 1232+64:
		defaultCamZoom -= 0.1;
	case 1243+64:
		defaultCamZoom += 0.05;
	case 1248+64:
		defaultCamZoom -= 0.1;
	case 1256+64|1259+64|1262+64:
		defaultCamZoom += 0.05;
	case 1266+64:
		defaultCamZoom -= 0.1;
	case 1346:
		defaultCamZoom = 0.75;
	case 1352:
		defaultCamZoom += 0.05;
	case 1358:
		defaultCamZoom -= 0.05;
	case 1370|1372|1374:
		defaultCamZoom += 0.05;
	case 1346+32:
		defaultCamZoom = 0.75;
	case 1352+32:
		defaultCamZoom += 0.05;
	case 1358+32:
		defaultCamZoom -= 0.05;
	case 1370+32|1372+32|1374+32:
		defaultCamZoom += 0.05;
	case 1408:
		defaultCamZoom -= 0.15;
	case 1416|1420|1432|1436:
		defaultCamZoom += 0.05;
	case 1408+32:
		defaultCamZoom -= 0.15;
	case 1416+32|1420+32|1432+32|1436+32:
		defaultCamZoom += 0.05;
	case 1472:
		defaultCamZoom -= 0.1;
	case 1504:
		defaultCamZoom += 0.1;
	case 1524|1532|1534:
		defaultCamZoom += 0.05;
	case 1472+64:
		defaultCamZoom -= 0.1;
	case 1504+64:
		defaultCamZoom += 0.1;
	case 1524+64|1532+64|1534+64:
		defaultCamZoom += 0.1;
	case 1600:
		defaultCamZoom = 0.8;
		camZoomingInterval = 1;
	case 1608:
		defaultCamZoom += 0.075;
	case 1612:
		defaultCamZoom += 0.05;
	case 1614:
		defaultCamZoom -= 0.1;
	case 1624:
		defaultCamZoom += 0.1;
	case 1632:
		defaultCamZoom -= 0.1;
	case 1648|1652|1656|1660:
		defaultCamZoom += 0.075;
	case 1600+64:
		defaultCamZoom = 0.8;
	case 1608+64:
		defaultCamZoom += 0.075;
	case 1612+64:
		defaultCamZoom += 0.05;
	case 1614+64:
		defaultCamZoom -= 0.1;
	case 1624+64:
		defaultCamZoom += 0.2;
		for(stage in stage.stageSprites) {
			FlxTween.color(stage, sectionCrochet / 2, stage.color, 0xff646464);
		}
	case 1632+64:
		defaultCamZoom -= 0.1;
		for(n => stage in stage.stageSprites) {
			if (n != 'Lake_Surface' && n != 'Mountain' && n != 'Snow')
				FlxTween.color(stage, sectionCrochet / 2, stage.color, 0xffffffff);
			else
				FlxTween.color(stage, sectionCrochet / 2, stage.color, 0xffc8c8c8);
		}
	case 1648+64|1652+64|1656+64|1660+64:
		defaultCamZoom += 0.075;
	case 1736:
		defaultCamZoom += 0.05;
	case 1738|1739:
		defaultCamZoom -= 0.05;
	case 1740:
		defaultCamZoom += 0.05;
	case 1744|1748:
		defaultCamZoom -= 0.05;
	case 1756:
		defaultCamZoom += 0.1;
	case 1760:
		defaultCamZoom -= 0.1;
	case 1736+64:
		defaultCamZoom += 0.05;
	case 1738+64|1739+64:
		defaultCamZoom -= 0.05;
	case 1740+64:
		defaultCamZoom += 0.05;
	case 1744+64|1748+64:
		defaultCamZoom -= 0.05;
	case 1756+64:
		defaultCamZoom += 0.1;
	case 1760+64:
		defaultCamZoom -= 0.1;
	case 1824:
		defaultCamZoom += 0.1;
	case 1832:
		defaultCamZoom -= 0.05;
	case 1840:
		defaultCamZoom += 0.05;
	case 1844:
		defaultCamZoom -= 0.05;
	case 1848:
		defaultCamZoom += 0.1;
	case 1852:
		defaultCamZoom -= 0.1;
		for(stage in stage.stageSprites) {
			FlxTween.color(stage, sectionCrochet / 4, stage.color, 0xffa0a0a0);
		}
	case 1856:
		defaultCamZoom += 0.1;
		for(n => stage in stage.stageSprites) {
			if (n != 'Lake_Surface' && n != 'Mountain' && n != 'Snow')
				FlxTween.color(stage, sectionCrochet / 4, stage.color, 0xffffffff);
			else
				FlxTween.color(stage, sectionCrochet / 4, stage.color, 0xffc8c8c8);
		}
	case 1884:
		defaultCamZoom += 0.1;
	case 1888:
		defaultCamZoom -= 0.15;
		colors1.alpha=1;
		FlxTween.tween(colors1, {alpha: 0}, 1);
	case 1976:
		defaultCamZoom += 0.1;
		camZoomingInterval = 114514;
	case 1984:
		defaultCamZoom -= 0.1;
		camZoomingInterval = 1;
	case 2016:
		defaultCamZoom += 0.1;
	case 2024:
		defaultCamZoom += 0.05;
	case 2048:
		defaultCamZoom -= 0.1;
	case 2080:
		defaultCamZoom += 0.1;
	case 2088:
		defaultCamZoom += 0.05;
	case 2112:
		defaultCamZoom -= 0.2;
		camZoomingInterval = 4;
		colors1.alpha=1;
		FlxTween.tween(colors1, {alpha: 0}, 2);
	case 2136:
		defaultCamZoom += 0.1;
	case 2146:
		defaultCamZoom -= 0.1;
	case 2162:
		defaultCamZoom += 0.1;
	case 2168:
		defaultCamZoom += 0.1;
	case 2162:
		defaultCamZoom += 0.1;
	case 2176:
		defaultCamZoom -= 0.2;
	case 2200:
		defaultCamZoom += 0.1;
	case 2210:
		defaultCamZoom -= 0.1;
	case 2226:
		defaultCamZoom += 0.1;
	case 2234:
		defaultCamZoom += 0.1;
	case 2240:
		defaultCamZoom -= 0.2;
	case 2266:
		defaultCamZoom += 0.1;
	case 2267:
		defaultCamZoom -= 0.05;
	case 2272|2276:
		defaultCamZoom += 0.05;
	case 2280:
		defaultCamZoom -= 0.05;
	case 2283:
		defaultCamZoom += 0.05;
	case 2286:
		defaultCamZoom += 0.05;
	case 2290:
		defaultCamZoom -= 0.15;
	case 2240+64:
		defaultCamZoom -= 0.2;
	case 2266+64:
		defaultCamZoom += 0.1;
	case 2267+64:
		defaultCamZoom -= 0.05;
	case 2272+64|2276+64:
		defaultCamZoom += 0.05;
	case 2280+64:
		defaultCamZoom -= 0.05;
	case 2283+64:
		defaultCamZoom += 0.05;
	case 2286+64:
		defaultCamZoom += 0.05;
	case 2368:
		FlxTween.num(defaultCamZoom, 0.5, sectionCrochet / 2, {}, (val:Float) -> {
			defaultCamZoom = val;
		});
	case 2376:
		colors2.alpha = 1;
	}
	if (step >= 576 && step < 704) {
		if (step % 8 == 0)
			FlxTween.num(0.1, 0, sectionCrochet / 2, {}, (val:Float) -> {
				colors3.alpha = val;
			});
	}
	if (step >= 1600 && step < 2112) {
		if (step % 4 == 0)
			FlxTween.num(0.05, 0, sectionCrochet / 4, {}, (val:Float) -> {
				colors3.alpha = val;
			});
	}
}