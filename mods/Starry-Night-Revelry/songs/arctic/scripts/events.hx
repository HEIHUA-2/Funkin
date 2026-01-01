import openfl.display.BlendMode;
import funkin.backend.utils.ThreadUtil;

var colors2:FunkinSprite;
var colors3:FunkinSprite;

var colorShader:CustomShader = new CustomShader('color');
colorShader.a = 0;
var colorShader1:CustomShader = new CustomShader('color');
colorShader1.a = 0;

var border:FunkinSprite = new FunkinSprite(0, 0, Paths.image('stages/border'));

function onPostStartCountdown() {
	if (!PlayState.isStoryMode) {
		introSprites = [null];
		introSounds = [null];
		Conductor.songPosition = 0;
	}
}

function postCreate() {
	colors2 = new FunkinSprite().makeGraphic(1, 1, 0xff000000);
	colors2.scale.set(1280, 720);
	colors2.updateHitbox();
	colors2.scrollFactor.set();
	colors2.zoomFactor = 0;
	colors2.alpha = 0;
	add(colors2);

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

	border.cameras = [camOther];
	border.addAnim('0', '00000');
	border.addAnim('1', '00001');
	border.playAnim('0', true);
	border.zoomFactor = 0;
	border.scrollFactor.set();
	border.colorTransform.alphaMultiplier = 0;
	border.blend = BlendMode.SCREEN;
	border.colorTransform.redMultiplier = border.colorTransform.greenMultiplier = border.colorTransform.blueMultiplier = 1.8;
	border.colorTransform.redOffset = 204 * 0.5;
	border.colorTransform.greenOffset = 231 * 0.5;
	border.colorTransform.blueOffset = 249 * 0.5;
	border.colorTransform.redOffset -= 500;
	border.colorTransform.greenOffset -= 500;
	border.colorTransform.blueOffset -= 500;
	add(border);
}

function onStartSong() {
	boyfriend.shader = colorShader;
	dad.shader = colorShader1;

	colorShader.c = colorRGBFloat(boyfriend.iconColor);
	colorShader1.c = colorRGBFloat(dad.iconColor);


	setCamFollowMoment(450, 250);
	cinematicBars(100, -1);
	FlxTween.num(0.9, 0.6, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 3, {ease:FlxEase.sineInOut}, (val:Float) -> {
		FlxG.camera.zoom = val;
	});
	FlxTween.num(0.7, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease:FlxEase.sineOut}, (val:Float) -> {
		colors2.alpha = val;
	});
}

event.createStep(56, () -> {
	FlxTween.num(0, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.sineOut}, (val:Float) -> {
		camHUD.alpha = val;
	});
});

event.createStep(64, () -> {
	camData.followChars = true;
});

event.createStep(114, () -> {
	defaultCamZoom += 0.05;
});

event.createStep(128, () -> {
	defaultCamZoom -= 0.05;
});

event.createStep(178, () -> {
	defaultCamZoom += 0.05;
});

event.createStep(192, () -> {
	camData.offset.y = 25;
	defaultCamZoom += 0.05;
	camZoomingInterval = 2;
});

event.createStep(216, () -> {
	defaultCamZoom -= 0.05;
}, [0, 64]);

event.createStep(219, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(224, () -> {
	defaultCamZoom -= 0.05;
}, [0, 64]);

event.createStep(228, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(230, () -> {
	defaultCamZoom -= 0.025;
}, [0, 64]);

event.createStep(232, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(234, () -> {
	defaultCamZoom -= 0.025;
}, [0, 64]);

event.createStep(235, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(238, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(256, () -> {
	defaultCamZoom = 0.8;
	defaultCamZoom -= 0.05;
});

event.createStep(306, () -> {
	defaultCamZoom += 0.05;
	for(stage in stage.stageSprites) {
		FlxTween.color(stage, 0.5, stage.color, 0xffafafaf);
	}
});

event.createStep(320, () -> {
	for(stage in stage.stageSprites) {
		FlxTween.color(stage, 1.5, stage.color, 0xffffffff);
	}
	defaultCamZoom = 0.7;
	defaultCamZoom -= 0.05;
	cinematicBars(0, 2);
});

event.createStep(328, () -> {
	defaultCamZoom += 0.05;
});

event.createStep(336, () -> {
	defaultCamZoom -= 0.05;
});

event.createStepAbsolute([346, 348, 350], () -> {
	defaultCamZoom += 0.05;
});

event.createStep(352, () -> {
	defaultCamZoom -= 0.1;
});

event.createStep(360, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(366, () -> {
	defaultCamZoom += 0.05;
});

event.createStep(368, () -> {
	defaultCamZoom -= 0.05;
});

event.createStepAbsolute([378, 380, 382], () -> {
	defaultCamZoom += 0.05;
});

event.createStep(392, () -> {
	defaultCamZoom += 0.05;
}, [0, 32]);

event.createStep(396, () -> {
	defaultCamZoom -= 0.05;
}, [0, 32]);

event.createStep(402, () -> {
	defaultCamZoom -= 0.1;
}, [0, 32]);

event.createStep(408, () -> {
	defaultCamZoom += 0.05;
}, [0, 32]);

event.createStep(410, () -> {
	defaultCamZoom -= 0.025;
}, [0, 32]);

event.createStep(412, () -> {
	defaultCamZoom += 0.05;
}, [0, 32]);

event.createStep(414, () -> {
	defaultCamZoom -= 0.025;
}, [0, 32]);

event.createStep(416, () -> {
	defaultCamZoom = 0.9;
	defaultCamZoom -= 0.05;
});

event.createStep(448, () -> {
	defaultCamZoom = 0.8;
	defaultCamZoom -= 0.05;
}, [0, 64]);

event.createStep(451, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(456, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(458, () -> {
	defaultCamZoom -= 0.025;
}, [0, 64]);

event.createStep(460, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(462, () -> {
	defaultCamZoom -= 0.025;
}, [0, 64]);

event.createStep(464, () -> {
	defaultCamZoom -= 0.05;
}, [0, 64]);

event.createStep(467, () -> {
	defaultCamZoom -= 0.05;
}, [0, 64]);

event.createStep(472, () -> {
	defaultCamZoom += 0.075;
}, [0, 64]);

event.createStep(476, () -> {
	defaultCamZoom += 0.075;
}, [0, 64]);

event.createStep(480, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(486, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(488, () -> {
	defaultCamZoom -= 0.075;
}, [0, 64]);

event.createStep(492, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(494, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(496, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(572, () -> {
	defaultCamZoom += 0.05;
});

event.createStep(576, () -> {
	defaultCamZoom = 0.75;
	defaultCamZoom -= 0.05;
});

event.createStep(704, () -> {
	defaultCamZoom = 1;
	defaultCamZoom -= 0.05;
});

event.createStep(832, () -> {
	camZoomingInterval = 114514;
	defaultCamZoom = 0.5;
	setCamFollow(450, 350);
	for (n => stage in stage.stageSprites) {
		FlxTween.color(stage, 4, stage.color, (n == 'light') ? 0x00000000 : 0xff000000);
	}

	FlxTween.num(defaultCamZoom, 0.7, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 16, {}, (val:Float) -> {
		defaultCamZoom = val;
	});

	FlxTween.num(0, 1, 4, {}, (val:Float) -> {
		colorShader.a = val;
		colorShader1.a = val;
		border.colorTransform.alphaMultiplier = val * 5;
		camHUD.alpha = 1 - val;
	});

	cinematicBars(100, 3);
});

event.createStep(944, () -> {
	FlxTween.num(0, 1, 4, {}, (val:Float) -> {
		camHUD.alpha = 1;
	});
	comboRatingSprites.alpha = healthbarNew.alpha = healthbarBGNew.alpha = scoreTxt.alpha = missesTxt.alpha = accuracyTxt.alpha = iconP1.alpha = iconP2.alpha = 0;
	for (strumLine in strumLines) for (strum in strumLine) strum.alpha = 0;
});

event.createStep(956, () -> {
	FlxTween.num(0, 1, 1, {}, (val:Float) -> {
		for (strum in player) strum.alpha = val;
	});
});

event.createStep(1020, () -> {
	FlxTween.num(0, 1, 1, {}, (val:Float) -> {
		for (strum in cpu) strum.alpha = val;
	});
});

event.createStep(1088, () -> {
	comboRatingSprites.alpha = healthbarNew.alpha = healthbarBGNew.alpha = scoreTxt.alpha = missesTxt.alpha = accuracyTxt.alpha = iconP1.alpha = iconP2.alpha = 1;

	cinematicBars(0, 4);
	defaultCamZoom = 0.8;
	defaultCamZoom -= 0.05;
	camData.followChars = true;
	flash(1, 0xffffffff, camBar, 1, 0);

	FlxTween.num(1, 0, 2, {}, (val:Float) -> {
		colorShader.a = val;
		colorShader1.a = val;
		border.colorTransform.alphaMultiplier = val * 5;
	});
	for (n => stage in stage.stageSprites) {
		FlxTween.color(stage, 2, stage.color, 0xffffffff);
	}
});

event.createStep(1096, () -> {
	defaultCamZoom = 0.9;
	defaultCamZoom -= 0.05;
});

event.createStep(1118, () -> {
	defaultCamZoom += 0.1;
}, [0, 64]);

event.createStep(1122, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(1134, () -> {
	defaultCamZoom += 0.1;
}, [0, 64]);

event.createStep(1152, () -> {
	defaultCamZoom = 0.9;
	defaultCamZoom -= 0.05;
});

event.createStep(1216, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(1222, () -> {
	defaultCamZoom += 0.1;
}, [0, 64]);

event.createStep(1232, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(1243, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(1248, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

for (i in [1256, 1259, 1262]) {
	event.createStep(i, () -> {
		defaultCamZoom += 0.05;
	}, [0, 64]);
}

event.createStep(1266, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(1346, () -> {
	defaultCamZoom = 0.75;
	defaultCamZoom -= 0.05;
}, [0, 32]);

event.createStep(1352, () -> {
	defaultCamZoom += 0.05;
}, [0, 32]);

event.createStep(1358, () -> {
	defaultCamZoom -= 0.05;
}, [0, 32]);

for (i in [1370, 1372, 1374]) {
	event.createStep(i, () -> {
		defaultCamZoom += 0.05;
	}, [0, 32]);
}

event.createStep(1408, () -> {
	defaultCamZoom -= 0.15;
}, [0, 32]);

for (i in [1416, 1420, 1432, 1436]) {
	event.createStep(i, () -> {
		defaultCamZoom += 0.05;
	}, [0, 32]);
}

event.createStep(1472, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(1504, () -> {
	defaultCamZoom += 0.1;
}, [0, 64]);

for (i in [1524, 1532, 1534]) {
	event.createStep(i, () -> {
		defaultCamZoom += 0.05;
	}, [0, 64]);
}

event.createStep(1588, () -> {
	for (strumLine in strumLines)
		for (strum in strumLine)
		{
			FlxTween.num(0, 720, 1, {ease: FlxEase.quartInOut}, (val:Float) -> {
				strum.angle = val;
			});
			FlxTween.num(strum.y, 75, 1, {ease: FlxEase.quartInOut}, (val:Float) -> {
				strum.y = val;
			});
		}
});

event.createStep(1596, () -> {
	for (strumLine in strumLines)
		for (strum in strumLine) {
			FlxTween.num(strum.angle - 360, 0, Conductor.getMeasuresInTime(0.25, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartIn}, (val:Float) -> {
				strum.angle = val;
			});
			FlxTween.num(strum.y, 0, Conductor.getMeasuresInTime(0.25, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartIn}, (val:Float) -> {
				strum.y = val;
			});
		}
});

event.createStep(1600, () -> {
	flash(1, 0xffffffff, camBar, 1, 0);
	border.colorTransform.redMultiplier = 1.7;
	border.colorTransform.greenMultiplier = 1.7;
	border.colorTransform.blueMultiplier = 1.7;
	border.colorTransform.redOffset = 204 * 0.5;
	border.colorTransform.greenOffset = 231 * 0.5;
	border.colorTransform.blueOffset = 249 * 0.5;
	border.colorTransform.redOffset -= 500;
	border.colorTransform.greenOffset -= 500;
	border.colorTransform.blueOffset -= 500;
	border.cameras = [FlxG.camera];

	defaultCamZoom = 0.8;
	defaultCamZoom -= 0.05;

	camZoomingInterval = 1;
	camZoomingStrength = 1.5;

	camHUD.alpha = 0.75;
	camHUD.fill(0xBFFFFFFF);
});

event.createStep(1608, () -> {
	defaultCamZoom += 0.075;
}, [0, 64]);

event.createStep(1612, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(1614, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(1624, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(1632, () -> {
	defaultCamZoom -= 0.1;
});

for (i in [1648, 1652, 1656, 1660]) {
	event.createStep(i, () -> {
		defaultCamZoom += 0.075;
	}, [0, 64]);
}

event.createStep(1664, () -> {
	defaultCamZoom = 0.8;
	defaultCamZoom -= 0.05;
});

event.createStep(1688, () -> {
	defaultCamZoom += 0.2;
	for (stage in stage.stageSprites) {
		FlxTween.color(stage, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2, stage.color, 0xffafafaf);
	}
});

event.createStep(1696, () -> {
	defaultCamZoom -= 0.1;
	for (n => stage in stage.stageSprites) {
		FlxTween.color(stage, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2, stage.color, 0xffffffff);
	}
});

event.createStep(1736, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

for (i in [1738, 1739]) {
	event.createStep(1738, () -> {
		defaultCamZoom -= 0.05;
	}, [0, 64]);
}

event.createStep(1740, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

for (i in [1744, 1748]) {
	event.createStep(1744, () -> {
		defaultCamZoom -= 0.05;
	}, [0, 64]);
}

event.createStep(1756, () -> {
	defaultCamZoom += 0.1;
}, [0, 64]);

event.createStep(1760, () -> {
	defaultCamZoom -= 0.1;
}, [0, 64]);

event.createStep(1832, () -> {
	defaultCamZoom -= 0.05;
});

event.createStep(1840, () -> {
	defaultCamZoom += 0.05;
});

event.createStep(1844, () -> {
	defaultCamZoom -= 0.05;
});

event.createStep(1848, () -> {
	defaultCamZoom += 0.1;
	for(stage in stage.stageSprites) {
		FlxTween.color(stage, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2, stage.color, 0xffcccccc);
	}
});

event.createStep(1852, () -> {
	defaultCamZoom -= 0.1;
});

event.createStep(1856, () -> {
	defaultCamZoom += 0.1;

	for (strumLine in strumLines)
		for (strum in strumLine)
		{
			FlxTween.num(strum.angle, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2, {ease:FlxEase.quartOut}, (val:Float) -> {
				strum.angle = val;
			});
			FlxTween.num(strum.y, 50, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2, {ease:FlxEase.quartOut}, (val:Float) -> {
				strum.y = val;
			});
		}
});

event.createStep(1884, () -> {
	defaultCamZoom += 0.1;
	for(n => stage in stage.stageSprites) {
		FlxTween.color(stage, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4, stage.color, 0xffffffff);
	}
});

event.createStep(1888, () -> {
	defaultCamZoom -= 0.15;
	flash(1, 0xffffffff, camBar, 1, 0);
});

event.createStep(1976, () -> {
	defaultCamZoom += 0.1;
	camZoomingInterval = 114514;
});

event.createStep(1984, () -> {
	defaultCamZoom -= 0.1;
	camZoomingInterval = 1;
});

event.createStep(2016, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(2024, () -> {
	defaultCamZoom += 0.05;
});

event.createStep(2048, () -> {
	defaultCamZoom -= 0.1;
});

event.createStep(2080, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(2088, () -> {
	defaultCamZoom += 0.05;
});

event.createStep(2112, () -> {
	defaultCamZoom -= 0.2;

	camZoomingInterval = 4;
	camZoomingStrength = 1;

	flash(1, 0xffffffff, camBar, 2, 0);

	camHUD.alpha = 0.9;

	for (strumLine in strumLines)
		for (strum in strumLine)
		{
			FlxTween.num(strum.angle, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 4, {ease:FlxEase.quartOut}, (val:Float) -> {
				strum.angle = val;
			});
			FlxTween.num(strum.y, 50, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 4, {ease:FlxEase.quartOut}, (val:Float) -> {
				strum.y = val;
			});
		}

	FlxTween.num(camHUD.angle, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 4, {ease: FlxEase.quartOut}, (val:Float) -> {
		camHUD.angle = val;
		comboRatingSprites.angle = -val;
	});
	
	dad.cameraOffset.x -= 25;
	boyfriend.cameraOffset.x += 25;
});

event.createStep(2136, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(2146, () -> {
	defaultCamZoom -= 0.1;
});

event.createStep(2162, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(2168, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(2176, () -> {
	defaultCamZoom -= 0.2;
});

event.createStep(2200, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(2210, () -> {
	defaultCamZoom -= 0.1;
});

event.createStep(2226, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(2234, () -> {
	defaultCamZoom += 0.1;
});

event.createStep(2240, () -> {
	defaultCamZoom -= 0.2;
}, [0, 64]);

event.createStep(2266, () -> {
	defaultCamZoom += 0.1;
}, [0, 64]);

event.createStep(2267, () -> {
	defaultCamZoom -= 0.05;
}, [0, 64]);

for (i in [2272, 2276]) {
	event.createStep(2272, () -> {
		defaultCamZoom += 0.05;
	}, [0, 64]);
}

event.createStep(2280, () -> {
	defaultCamZoom -= 0.05;
}, [0, 64]);

event.createStep(2283, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(2286, () -> {
	defaultCamZoom += 0.05;
}, [0, 64]);

event.createStep(2290, () -> {
	defaultCamZoom -= 0.15;
});

event.createStep(2368, () -> {
	FlxTween.num(defaultCamZoom, defaultCamZoom - 0.3, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2, {ease:FlxEase.quartOut}, (val:Float) -> {
		defaultCamZoom = val;
	});
});

event.createStep(2376, () -> {
	colors2.cameras = [camOther];
	colors2.alpha = 1;
	border.colorTransform.alphaMultiplier = 0;
});

function stepHit(step:Int) {
	if (step == 1536) camData.offset.x -= 100;
	if (step == 1588) camData.offset.x -= 25;
	if (step == 1596) camData.offset.x -= 25;
	if (step == 1600) camData.offset.x += 150;
	if (step == 1648) camData.offset.x -= 100;
	if (step == 1664) camData.offset.x += 100;
	if (step == 1688) camData.offset.x += 100;
	if (step == 1696) camData.offset.x -= 100;
	if (step == 1728) camData.offset.x -= 50;
	if (step == 1792) camData.offset.x += 50;
	if (step == 1816) camData.offset.x += 50;
	if (step == 1824) camData.offset.x -= 50;
	if (step == 1852) camData.offset.x += 50;
	if (step == 1920) camData.offset.x -= 100;
	if (step == 1984) camData.offset.x += 100;
	if (step == 2048) camData.offset.x -= 100;
	if (step == 2112) camData.offset.x += 50;

	if ((step >= 1600 && step < 1688) || (step >= 1696 && step < 1816) || (step >= 1824 && step < 1852) || (step >= 1888 && step < 2112)) {
		if (step < 1888)
		{
			if (step % 4 == 0)
			{
				for (strumLine in strumLines)
				{
					for (strum in strumLine) {
						var strumID = (strum.ID + (step % 8 == 0 ? 0 : 1)) % 2;
						var angle = strumID == 0 ? 5 : -5;
						var y1 = strumID == 0 ? 2.5 : -2.5;
						var y2 = strumID == 0 ? 10 : -10;
						FlxTween.tween(strum, {angle: angle}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.backIn});
						FlxTween.num(strum.y - y1, 50 - y2, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartOut},
							(val:Float) -> {
								strum.y = val;
							});
						FlxTween.num(0.5, 0.7, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartOut}, (val:Float) -> {
							strum.scale.x = val;
						});
						FlxTween.num(0.9, 0.7, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartOut}, (val:Float) -> {
							strum.scale.y = val;
						});
					}
				}
			}
		}
		else
		{
			if (step % 4 == 0)
				for (strumLine in strumLines) {
					var i = 0;

					if (step % 8 == 4) i = 1;

					for (strum in [strumLine.members[step % 2 + i], strumLine.members[step % 2 + 2 + i]]) {
						FlxTween.tween(strum, {angle: 5}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.backIn});
						FlxTween.tween(strum, {y: 50 - 25}, Conductor.getStepsInTime(2, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.sineOut});
						strum.scale.set(0.5, 0.9);
						FlxTween.tween(strum.scale, {x: 0.7, y: 0.7}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartOut});
					}
					for (strum in [strumLine.members[step % 2 + 1 - i], strumLine.members[step % 2 + 3 - i]]) {
						FlxTween.tween(strum, {angle: -5}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.backIn});
					}
				}

			if (step % 4 == 2)
			{
				var i = 0;

				if (step % 8 == 6) i = 1;

				for (strumLine in strumLines)
					for (strum in [strumLine.members[step % 2 + i], strumLine.members[step % 2 + 2 + i]])
					{
						FlxTween.tween(strum, {y: 50}, Conductor.getStepsInTime(2, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quintIn});
					}
			}
		}
		if (step % 4 == 0)
			FlxTween.num(camHUD.angle, step % 8 == 0 ? 0.6 : -0.6, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.backIn}, (val:Float) -> {
				camHUD.angle = val;
				comboRatingSprites.angle = -val;
			});
	}

	if (step % 8 == 0)
		border.playAnim('0', true);
	if (step % 8 == 4)
		border.playAnim('1', true);
}

event.createStepPeriodic([[576, 704, true, false]], [[8]], () -> {
	FlxTween.num(0.1, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2, {}, (val:Float) -> {
		colors3.alpha = val;
	});
});

event.createStepPeriodic([[1600, 2112, true, false]], [[4]], () -> {
	FlxTween.num(0.05, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4, {ease: FlxEase.sineOut}, (val:Float) -> {
		colors3.alpha = val;
	});
	FlxTween.num(20, 5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4, {ease: FlxEase.sineOut}, (val:Float) -> {
		border.colorTransform.alphaMultiplier = val;
	});
});