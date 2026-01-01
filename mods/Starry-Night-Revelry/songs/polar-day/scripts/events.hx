import flixel.group.FlxSpriteGroup;
import shaders.BlurShader;
import shaders.songs.polarday.SnowShader;

var blur_1:CustomShader = new BlurShader();
add(blur_1);
var blur_2:CustomShader = new BlurShader();
add(blur_2);
blur_1.applyShader(FlxG.camera);
blur_2.applyShader(FlxG.camera);

var flashGraphic = new FunkinSprite().makeGraphic(1, 1, 0xff000000);
flashGraphic.scale.set(FlxG.width, FlxG.height);
flashGraphic.updateHitbox();
flashGraphic.scale.set(FlxG.width * 2, FlxG.height * 2);
flashGraphic.scrollFactor.set();
flashGraphic.zoomFactor = 0;

var background_flash = new FunkinSprite(-800, -1450, Paths.image('stages/light'));
background_flash.scale.set(10, 10);
background_flash.updateHitbox();
background_flash.antialiasing = true;
// background_flash.scale.set(FlxG.width * 2, FlxG.height * 2);
// background_flash.scrollFactor.set();
// background_flash.zoomFactor = 0;
background_flash.colorTransform.redOffset = 200;
background_flash.colorTransform.greenOffset = 200;
background_flash.colorTransform.blueOffset = 200;
background_flash.blend = 0;
background_flash.alpha = 0;
insert(members.indexOf(stage.stageSprites['snow']), background_flash);

var distortion_amplification:CustomShader = new CustomShader('distortion_amplification');
distortion_amplification.strength = 0;
FlxG.camera.addShader(distortion_amplification);

var saturation:CustomShader = new CustomShader('saturation');
saturation.saturation = 1.15;
saturation.offset = 0.9;
saturation.multiply = 1.25;
saturation.luminance_contrast = 1;
FlxG.camera.addShader(saturation);

var mirror_repeat_effect:CustomShader = new CustomShader('mirror_repeat_effect');
mirror_repeat_effect.x = 0;
mirror_repeat_effect.y = 0;
mirror_repeat_effect.zoom = 1;
mirror_repeat_effect.angle = 0;
FlxG.camera.addShader(mirror_repeat_effect);

var hueShift:CustomShader = new CustomShader('polar-day/hueShift');
hueShift.hueShift = [Math.cos(0), Math.sin(0)];
hueShift.pixelSize = [0, 0];

var hueShift_note:CustomShader = new CustomShader('polar-day/hueShift');
hueShift_note.hueShift = [Math.cos(0), Math.sin(0)];
hueShift_note.pixelSize = [0.1, 0.1];

var snowParticle = new FlxSpriteGroup(0, 0);
snowParticle.scrollFactor.set();

var agglomerate_fog_1 = new FunkinSprite(-1400, -300, Paths.image('stages/agglomerate_fog_1'));
agglomerate_fog_1.antialiasing = true;
agglomerate_fog_1.scale.set(2, 1.1);
agglomerate_fog_1.updateHitbox();
agglomerate_fog_1.blend = 0;
agglomerate_fog_1.scrollFactor.set(1.1, 1.1);
agglomerate_fog_1.zoomFactor = 1.1;
agglomerate_fog_1.shader = new CustomShader('polar-day/mirror_repeat_effect_alpha');
agglomerate_fog_1.shader.x = 0;
agglomerate_fog_1.shader.zoom = 1;
agglomerate_fog_1.alpha = 0;

var agglomerate_fog_2 = new FunkinSprite(-1400, -300, Paths.image('stages/agglomerate_fog_2'));
agglomerate_fog_2.antialiasing = true;
agglomerate_fog_2.scale.set(2, 1.1);
agglomerate_fog_2.updateHitbox();
agglomerate_fog_2.blend = 0;
agglomerate_fog_2.scrollFactor.set(1.1, 1.1);
agglomerate_fog_2.zoomFactor = 1.1;
agglomerate_fog_2.shader = new CustomShader('polar-day/mirror_repeat_effect_alpha');
agglomerate_fog_2.shader.x = 0;
agglomerate_fog_2.shader.zoom = 1;
agglomerate_fog_2.alpha = 0;

var agglomerate_fog_3 = new FunkinSprite(-1200, -500, Paths.image('stages/agglomerate_fog_1'));
agglomerate_fog_3.antialiasing = true;
agglomerate_fog_3.scale.set(2, 1.1);
agglomerate_fog_3.updateHitbox();
agglomerate_fog_3.blend = 0;
agglomerate_fog_3.scrollFactor.set(0.8, 0.8);
agglomerate_fog_3.zoomFactor = 0.8;
agglomerate_fog_3.flipX = true;
agglomerate_fog_3.alpha = 0;
agglomerate_fog_3.shader = new CustomShader('polar-day/mirror_repeat_effect_alpha');
agglomerate_fog_3.shader.x = 0;
agglomerate_fog_3.shader.zoom = 1;

var agglomerate_fog_4 = new FunkinSprite(-1200, -500, Paths.image('stages/agglomerate_fog_2'));
agglomerate_fog_4.antialiasing = true;
agglomerate_fog_4.scale.set(2, 1.1);
agglomerate_fog_4.updateHitbox();
agglomerate_fog_4.blend = 0;
agglomerate_fog_4.scrollFactor.set(0.6, 0.6);
agglomerate_fog_4.zoomFactor = 0.6;
agglomerate_fog_4.flipX = true;
agglomerate_fog_4.alpha = 0;
agglomerate_fog_4.shader = new CustomShader('polar-day/mirror_repeat_effect_alpha');
agglomerate_fog_4.shader.x = 0;
agglomerate_fog_4.shader.zoom = 1;

var agglomerate_fog_speed = [0.1, -0.1, -0.2, 0.13];

var prospect_flash = new FunkinSprite(0, 100, Paths.image('stages/light'));
prospect_flash.scale.set(1280 / prospect_flash.width, 720 / prospect_flash.height);
prospect_flash.updateHitbox();
prospect_flash.scale.add(5, 7.5);
prospect_flash.antialiasing = true;
prospect_flash.scrollFactor.set();
prospect_flash.zoomFactor = 0;
prospect_flash.colorTransform.blueOffset = 100;
prospect_flash.blend = 0;
prospect_flash.alpha = 0;
prospect_flash.flipY = true;

var snowSprite = new FunkinSprite().makeGraphic(1, 1, 0x00000000);
snowSprite.scale.set(FlxG.width, FlxG.height);
snowSprite.updateHitbox();
snowSprite.scrollFactor.set();
snowSprite.zoomFactor = 0;
snowSprite.alpha = 0;

var snowShader = new SnowShader();
snowShader.applyShader(snowSprite);
add(snowShader);

for (i in 0...25) {
	var particle = new FunkinSprite(0, 0, Paths.image('stages/snow0' + FlxG.random.int(0, 6)));
	particle.antialiasing = false;
	particle.alpha = 0;
	particle.scrollFactor.set();
	particle.zoomFactor = 0;
	snowParticle.add(particle);
}

function strumLinePos() {
	for (strumLine in strumLines)
		for (strum in strumLine) {
			strum.y = FlxG.random.float(35, 65);
		}
}

function postCreate() {
	strumLines.members[0].onHit.add((event) -> {
		for (strum in strumLines.members[2]) {
			strum.alpha = 0;
			strum.offset.y += 10000;
		}
	});
	strumLines.members[2].onHit.add((event) -> {
		cpu.members[event.note.__strum.ID].press(event.note.strumTime);
		for (strum in strumLines.members[2]) {
			strum.alpha = 0;
			strum.offset.y += 10000;
		}
	});

	camZoomingStrength = 0.5;

	var time = [Conductor.getStepsInTime(1696, Conductor.curChangeIndex), Conductor.getStepsInTime(1952, Conductor.curChangeIndex)];
	for (note in strumLines.members[1].notes) {
		if (note.strumTime >= time[0] && note.strumTime <= time[1])
			note.shader = hueShift_note;
	}

	for (strum in strumLines.members[2]) {
		strum.alpha = 0;
		strum.offset.y += 10000;
	}

	camHUD.alpha = 0;

	bf.shader = hueShift;

	add(flashGraphic);

	setCamFollowMoment(1000, 450);

	addBfCamOffset(0, 25);

	add(snowParticle);
	
	insert(members.indexOf(stage.stageSprites['snow']), snowSprite);

	insert(members.indexOf(stage.stageSprites['snow']), agglomerate_fog_3);
	insert(members.indexOf(stage.stageSprites['snow']), agglomerate_fog_4);

	insert(members.indexOf(stage.stageSprites['snow_drift']), agglomerate_fog_1);
	insert(members.indexOf(stage.stageSprites['snow_drift']), agglomerate_fog_2);

	add(prospect_flash);
}

function onStartSong() {
	FlxTween.num(0.75, 0, Conductor.getMeasuresInTime(4, Conductor.curChangeIndex) * 0.001, {
		onComplete: function(tween:FlxTween) {
			flashGraphic.destroy();
		}
	}, (val:Float) -> {
		flashGraphic.alpha = val;
	});

	setCamZoomMoment(1.2);
	FlxTween.num(FlxG.camera.zoom, 1, Conductor.getMeasuresInTime(3.75, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepOut}, (val:Float) -> {
		FlxG.camera.zoom = val;
	});
	FlxTween.num(100, 0, Conductor.getMeasuresInTime(3.75, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepOut}, (val:Float) -> {
		blur_1.blur_size = [val, 0];
		blur_2.blur_size = [0, val];
	});
}

var w:Bool = true;
var flashSizes = 1;
function stepHit(step:Int) {
	if ((step >= 672 && step <= 1168) || (step >= 2208 && step < 2456)) {
		var particle = findTransparentParticle();
		var int = FlxG.random.int(0, 1);
		if (int == 0) {
			particle.setPosition(-150, FlxG.random.int(-150, 720));
			particle.alpha = 1;
			FlxTween.tween(particle, {x: FlxG.random.float(100, 200) - 150, y: particle.y + FlxG.random.float(-30, 30), angle: FlxG.random.float(-20, 20), alpha: 0}, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepOut});
		} else if (int == 1) {
			particle.setPosition(1430, FlxG.random.int(-150, 720));
			particle.alpha = 1;
			FlxTween.tween(particle, {x: FlxG.random.float(1180, 1080), y: particle.y + FlxG.random.float(-30, 30), angle: FlxG.random.float(-20, 20), alpha: 0}, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepOut});
		}
	}
	if (((step >= 672 && step <= 1168) || (step >= 2080 && step < 2456)) && step % 16 == 8) {
		w = !w;
		FlxTween.num((w ? 1 : -1) * flashSizes, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartOut}, (val:Float) -> {
			mirror_repeat_effect.angle = val;
		});
		FlxTween.num(0.4 * flashSizes, 0.2 * flashSizes, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepIn}, (val:Float) -> {
			background_flash.alpha = val;
		});
		FlxTween.num(1 * flashSizes, 0.8 * flashSizes, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepIn}, (val:Float) -> {
			prospect_flash.alpha = val;
		});
		FlxTween.num(1.25 + 0.3 * flashSizes, 1.25, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepIn}, (val:Float) -> {
			saturation.multiply = val;
		});
	}
}

function postUpdate(elapsed) {
	if (Conductor.curStep >= 1696 && Conductor.curStep < 1952) {
		camHUD.angle = Math.sin((Conductor.curStepFloat - 1696) / 16) * 2;
		comboRatingSprites.angle = -camHUD.angle;
	}
	for (i => agglomerate_fog in [agglomerate_fog_1, agglomerate_fog_2, agglomerate_fog_3, agglomerate_fog_4]) {
		agglomerate_fog.shader.x += agglomerate_fog_speed[i] * elapsed * 0.1;
	}
}

event.createStep(60, () -> {
	FlxTween.num(0, 1, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartIn}, (val:Float) -> {
		distortion_amplification.strength = val;
	});
	FlxTween.num(FlxG.camera.zoom, 1.5, Conductor.getMeasuresInTime(0.25, Conductor.curChangeIndex) * 0.001, {
		ease: FlxEase.quartIn,
		onComplete: function(tween:FlxTween) {
			setCamZoomMoment(1.1);
			distortion_amplification.strength = 0;
			FlxTween.num(0.9, 1, 0.5, {ease: FlxEase.quartOut}, (val:Float) -> {
				mirror_repeat_effect.zoom = val;
			});
			FlxTween.num(200, 100, Conductor.getMeasuresInTime(2, Conductor.curChangeIndex) * 0.001, {
				onComplete: function(tween:FlxTween) {
					var pos = getStrumlineCamPosHxAvg([0, 1]);
					setCamFollowMoment(pos.x, pos.y);
					setCamZoomMoment(0.7);
					FlxG.camera.zoom = 0.8;
				}
			}, (val:Float) -> {
				setCamFollowMoment(val, 380);
			});
		}
	}, (val:Float) -> {
		FlxG.camera.zoom = val;
	});
});

event.createStep(96, () -> {
	camZooming = true;

	camHUD.alpha = 1;
	camHUD.zoom = 1.2;
	defaultCamZoom = 0.8;
});

event.createStep(120, () -> {
	var pos = getStrumlineCamPosHx(1).pos;
	FlxTween.tween(FlxG.camera.scroll, {x: pos.x - FlxG.camera.width / 2, y: pos.y - FlxG.camera.height / 2}, Conductor.getStepsInTime(8, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartIn});
	FlxTween.num(0, 0, Conductor.getStepsInTime(8, Conductor.curChangeIndex) * 0.001, {
		onComplete: () -> {
			setCamFollowMoment();
		}
	}, (val:Float) -> {
		setCamFollowMoment(FlxG.camera.scroll.x + FlxG.camera.width / 2, FlxG.camera.scroll.y + FlxG.camera.height / 2);
	});
	FlxTween.num(FlxG.camera.zoom, 0.85, Conductor.getStepsInTime(8, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepOut}, (val:Float) -> {
		setCamZoomMoment(val);
	});
});

event.createStep(128, () -> {
	camZoomingInterval = 2;
	setCamFollowMoment();
	FlxTween.num(0.01, 0, 0.1, {ease: FlxEase.smoothStepOut}, (val:Float) -> {
		FlxG.camera.shake(val);
	});
	FlxTween.num(0.9, 1, 0.5, {ease: FlxEase.quartOut}, (val:Float) -> {
		mirror_repeat_effect.zoom = val;
	});
});

event.createStep(144, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(148, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(151, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(159, () -> {
	defaultCamZoom = 0.9;
}, [0, 16 * 16]);

event.createStep(184, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(192, () -> {
	defaultCamZoom = 0.9;
}, [0, 16 * 16]);

event.createStep(208, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(215, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(224, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(248, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(256, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(272, () -> {
	defaultCamZoom = 0.9;
}, [0, 16 * 16]);

event.createStep(279, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(282, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(288, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(294, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(300, () -> {
	defaultCamZoom = 0.925;
}, [0, 16 * 16]);

event.createStep(320, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(348, () -> {
	defaultCamZoom = 0.9;
});

event.createStep(376, () -> {
	var pos = getStrumlineCamPosHx(0).pos;
	FlxTween.tween(FlxG.camera.scroll, {x: pos.x - FlxG.camera.width / 2, y: pos.y - FlxG.camera.height / 2}, Conductor.getStepsInTime(8, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartIn});
	FlxTween.num(0, 0, Conductor.getStepsInTime(8, Conductor.curChangeIndex) * 0.001, {
		onComplete: () -> {
			setCamFollowMoment();
		}
	}, (val:Float) -> {
		setCamFollowMoment(FlxG.camera.scroll.x + FlxG.camera.width / 2, FlxG.camera.scroll.y + FlxG.camera.height / 2);
	});
});

event.createStep(384, () -> {
	FlxTween.num(1.1, 1, 0.5, {ease: FlxEase.quartOut}, (val:Float) -> {
		mirror_repeat_effect.zoom = val;
	});
});

event.createStep(572, () -> {
	var pos = getStrumlineCamPosHxAvg([0, 1]);
	FlxTween.tween(FlxG.camera.scroll, {x: pos.x - FlxG.camera.width / 2, y: pos.y - FlxG.camera.height / 2}, Conductor.getStepsInTime(32, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepInOut});
	FlxTween.num(0, 0, Conductor.getStepsInTime(32, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		setCamFollowMoment(FlxG.camera.scroll.x + FlxG.camera.width / 2, FlxG.camera.scroll.y + FlxG.camera.height / 2);
	});
	FlxTween.num(FlxG.camera.zoom, 0.6, Conductor.getStepsInTime(32, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartInOut}, (val:Float) -> {
		setCamZoomMoment(val);
	});
});

event.createStep(604, () -> {
	var pos = getStrumlineCamPosHxAvg([0, 1]);
	setCamFollowMoment(pos.x, pos.y);
});

event.createStep(636, () -> {
	var pos = getStrumlineCamPosHx(1).pos;
	FlxTween.tween(FlxG.camera.scroll, {x: pos.x - FlxG.camera.width / 2, y: pos.y - FlxG.camera.height / 2}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepIn});
	FlxTween.num(0, 0, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		setCamFollowMoment(FlxG.camera.scroll.x + FlxG.camera.width / 2, FlxG.camera.scroll.y + FlxG.camera.height / 2);
	});
	FlxTween.num(FlxG.camera.zoom, 0.8, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartIn}, (val:Float) -> {
		setCamZoomMoment(val);
	});
	FlxTween.num(360, 0, Conductor.getStepsInTime(8, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartInOut}, (val:Float) -> {
		mirror_repeat_effect.angle = val;
	});
	for (stage in stage.stageSprites) {
		FlxTween.tween(stage.colorTransform, {redOffset: -100, greenOffset: -100, blueOffset: -100}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepIn});
	}
	var col = [232 / 255 * 0.7, 228 / 255 * 0.7, 255 / 255 * 0.7];
	FlxTween.num(col[0], 85 / 255 * 0.9, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		col[0] = val;
	});
	FlxTween.num(col[1], 86 / 255 * 0.9, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		col[1] = val;
	});
	FlxTween.num(col[2], 111 / 255 * 0.9, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		col[2] = val;
		shadow_optimization_licanis.color = col;
		dadShadow.shader.color = col;
		bfShadow.shader.color = col;
	});
	FlxTween.num(0, 0.75, Conductor.getStepsInTime(16, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		agglomerate_fog_1.alpha = agglomerate_fog_2.alpha = agglomerate_fog_3.alpha = agglomerate_fog_4.alpha = val;
	});
	camZoomingInterval = 114514;
	cinematicBars(50, 2);
	FlxTween.num(1, 0, 2, {}, (val:Float) -> {
		for (ui in [comboRatingSprites, healthbarNew, healthbarBGNew, iconP1, iconP2, scoreTxt, missesTxt, accuracyTxt]) ui.alpha = val;
	});
});

// event.createStep(640, () -> {
// 	FlxTween.num(defaultHudZoom, 1.01, Conductor.getStepsInTime(32, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepInOut}, (val:Float) -> {
// 		defaultHudZoom = camHUD.zoom = val;
// 	});
// });

event.createStep(644, () -> {
	setCamFollowMoment();
});

event.createStep(668, () -> {
	FlxTween.num(0, 1, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartIn}, (val:Float) -> {
		distortion_amplification.strength = val;
	});
	FlxTween.num(FlxG.camera.zoom, 1.5, Conductor.getStepsInTime(3, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartIn}, (val:Float) -> {
		defaultCamZoom = val;
	});
});

// event.createStep(668, () -> {
// 	FlxTween.num(camHUD.zoom, 0.95, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartIn}, (val:Float) -> {
// 		defaultHudZoom = camHUD.zoom = val;
// 	});
// });

event.createStep(672, () -> {
	camZoomingStrength = 0.75;
	camZoomingInterval = 2;
	camZoomingStrength = 1.5;

	var pos = getStrumlineCamPosHxAvg([0, 1]);
	setCamFollowMoment(pos.x, pos.y);
	setCamZoomMoment(0.65);
	FlxG.camera.zoom -= 0.1;

	camGameZoomLerp = 0.01;

	defaultHudZoom = 0.95;

	FlxTween.num(-1, 0, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quartOut}, (val:Float) -> {
		distortion_amplification.strength = val;
	});
	prospect_flash.alpha = 0.8;
});

event.createStep(740, () -> {
	var pos = getStrumlineCamPosHx(1).pos;
	setCamFollow(pos.x, pos.y);
	defaultCamZoom = 0.9;
});

event.createStep(800, () -> {
	var pos = getStrumlineCamPosHxAvg([0, 1]);
	setCamFollow(pos.x, pos.y);

	defaultCamZoom = 0.65;
});

event.createStep(868, () -> {
	var pos = getStrumlineCamPosHx(1).pos;
	setCamFollow(pos.x, pos.y);
	defaultCamZoom = 0.9;
});

event.createStep(928, () -> {
	var pos = getStrumlineCamPosHxAvg([0, 1]);
	setCamFollow(pos.x, pos.y);

	defaultCamZoom = 0.65;
});

event.createStep(996, () -> {
	var pos = getStrumlineCamPosHx(0).pos;
	setCamFollow(pos.x, pos.y);

	defaultCamZoom = 0.9;
});

event.createStep(1028, () -> {
	var pos = getStrumlineCamPosHx(2).pos;
	setCamFollow(pos.x, pos.y);
});

event.createStep(1056, () -> {
	var pos = getStrumlineCamPosHxAvg([0, 1]);
	FlxTween.tween(FlxG.camera.scroll, {x: pos.x - FlxG.camera.width / 2, y: pos.y - FlxG.camera.height / 2}, Conductor.getStepsInTime(32, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.sineInOut});
	FlxTween.num(0, 0, Conductor.getStepsInTime(32, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		setCamFollowMoment(FlxG.camera.scroll.x + FlxG.camera.width / 2, FlxG.camera.scroll.y + FlxG.camera.height / 2);
	});
	FlxTween.num(FlxG.camera.zoom, 0.55, Conductor.getMeasuresInTime(7, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		defaultCamZoom = val;
	});
});

event.createStep(1176, () -> {
	var pos = getStrumlineCamPosHx(0).pos;
	FlxTween.tween(FlxG.camera.scroll, {x: pos.x - FlxG.camera.width / 2 - 100, y: pos.y - FlxG.camera.height / 2 + 50}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepOut});
	FlxTween.num(0, 0, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		setCamFollowMoment(FlxG.camera.scroll.x + FlxG.camera.width / 2, FlxG.camera.scroll.y + FlxG.camera.height / 2);
	});
	
	var col = [85 / 255 * 0.9, 86 / 255 * 0.9, 111 / 255 * 0.9];
	FlxTween.num(col[0], 232 / 255 * 0.7, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		col[0] = val;
	});
	FlxTween.num(col[1], 228 / 255 * 0.7, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		col[1] = val;
	});
	FlxTween.num(col[2], 255 / 255 * 0.7, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		col[2] = val;
		shadow_optimization_licanis.color = col;
		dadShadow.shader.color = col;
		bfShadow.shader.color = col;
	});
	FlxTween.num(agglomerate_fog_1.alpha, 0, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		agglomerate_fog_1.alpha = agglomerate_fog_2.alpha = agglomerate_fog_3.alpha = agglomerate_fog_4.alpha = val;
	});
	for (stage in stage.stageSprites) {
		FlxTween.tween(stage.colorTransform, {redOffset: 0, greenOffset: 0, blueOffset: 0}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001);
	}
	FlxTween.tween(background_flash, {alpha: 0}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001);
	FlxTween.tween(prospect_flash, {alpha: 0}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001);
	FlxTween.num(0, 1, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		for (ui in [comboRatingSprites, healthbarNew, healthbarBGNew, iconP1, iconP2, scoreTxt, missesTxt, accuracyTxt]) ui.alpha = val;
	});
	cinematicBars(0, 1);

	defaultHudZoom = 1;
	defaultCamZoom = 1.2;

	camGameZoomLerp = 0.05;
});

event.createStep(1184, () -> {
	camZoomingInterval = 4;
	camZoomingStrength = 1.5;
	defaultCamZoom = 0.8;
	setCamFollowMoment();
	for (strumLine in strumLines) for (strum in strumLine) strum.y = 50;
	flash(1, null, null, 0.8);
});

event.createStep(1200, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(1207, () -> {
	defaultCamZoom = 0.9;
}, [0, 16 * 16]);

event.createStep(1215, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(1240, () -> {
	defaultCamZoom = 0.825;
}, [0, 16 * 16]);

event.createStep(1248, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(1264, () -> {
	defaultCamZoom = 0.9;
}, [0, 16 * 16]);

event.createStep(1280, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(1312, () -> {
	defaultCamZoom = 0.9;
}, [0, 16 * 16]);

event.createStep(1328, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(1335, () -> {
	defaultCamZoom = 0.85;
}, [0, 16 * 16]);

event.createStep(1344, () -> {
	defaultCamZoom = 0.9;
}, [0, 16 * 16]);

event.createStep(1376, () -> {
	defaultCamZoom = 0.95;
}, [0, 16 * 16]);

event.createStep(1392, () -> {
	defaultCamZoom = 0.9;
}, [0, 16 * 16]);

event.createStep(1404, () -> {
	defaultCamZoom = 0.875;
}, [0, 16 * 16]);

event.createStep(1428, () -> {
	camZoomingInterval = 2;
	camZoomingStrength = 0.5;
});

event.createStep(1432, () -> {
	var pos = getStrumlineCamPosHx(1).pos;
	FlxTween.tween(FlxG.camera.scroll, {x: pos.x - FlxG.camera.width / 2 + 100, y: pos.y - FlxG.camera.height / 2 + 50}, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepOut});
	FlxTween.num(0, 0, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		setCamFollowMoment(FlxG.camera.scroll.x + FlxG.camera.width / 2, FlxG.camera.scroll.y + FlxG.camera.height / 2);
	});
	defaultCamZoom = 1.2;
});

event.createStep(1432, strumLinePos, [0, 1, 2, 3, 4, 5, 6, 7]);

event.createStep(1440, () -> {
	setCamFollowMoment();
	defaultCamZoom = 0.8;
	for (strumLine in strumLines) for (strum in strumLine) strum.y = 50;
	flash(1, null, null, 0.8);
});

event.createStep(1688, () -> {
	FlxTween.num(defaultCamZoom, 1.5, Conductor.getStepsInTime(7, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		defaultCamZoom = val;
	});
	FlxTween.num(0, 40, Conductor.getStepsInTime(7, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		blur_1.blur_size = [val, 0];
		blur_2.blur_size = [0, val];
	});
	flashInOut(Conductor.getStepsInTime(7, Conductor.curChangeIndex) * 0.001, Conductor.getStepsInTime(1, Conductor.curChangeIndex) * 0.001, -1, 0xff000000);
});

event.createStep(1688, strumLinePos, [0, 1, 2, 3, 4, 5, 6, 7]);

event.createStep(1696, () -> {
	blur_1.blur_size = [0, 0];
	blur_2.blur_size = [0, 0];
	for (strum in player) strum.shader = bf.shader;
	iconP1.shader = bf.shader;
	bf.animation.playCallback = bfCol;
	hueShift.pixelSize = [0.05, 0.05];
	camZoomingStrength = 1;
	flash(1, null, camHUD, 0.8);
	for (strumLine in strumLines) for (strum in strumLine) strum.y = 50;
	FlxTween.num(0.8, 1, Conductor.getMeasuresInTime(8, Conductor.curChangeIndex) * 0.001, {onComplete: () -> {
	  defaultCamZoom = 0.8;
	}
	}, (val:Float) -> {
		defaultCamZoom = val;
	});
});

event.createStep(1856, () -> {
	defaultCamZoom = 0.85;
});

event.createStep(1872, () -> {
	defaultCamZoom = 0.9;
});

event.createStep(1894, () -> {
	defaultCamZoom = 0.8;
});

event.createStep(1920, () -> {
	defaultCamZoom = 0.9;
});

event.createStep(1936, () -> {
	var pos = getStrumlineCamPosHxAvg([0, 1]);
	setCamFollow(pos.x, pos.y);
	FlxTween.num(0.6, 1.5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quintIn}, (val:Float) -> {
		defaultCamZoom = val;
	});
});

event.createStep(1944, () -> {
	flashInOut(Conductor.getStepsInTime(8, Conductor.curChangeIndex) * 0.001, -1, -1, 0xff000000);
});

event.createStep(1952, () -> {
	for (strum in player) strum.shader = null;
	iconP1.shader = bf.shader = null;
	bf.animation.playCallback = null;
	flash(1, 0xff000000, camHUD, 0.6);
	camHUD.angle = 0;
	camZoomingStrength = 0.5;

	var col = [85 / 255 * 0.9, 86 / 255 * 0.9, 111 / 255 * 0.9];
	shadow_optimization_licanis.color = col;
	dadShadow.shader.color = col;
	bfShadow.shader.color = col;
	for (stage in stage.stageSprites) {
		stage.colorTransform.redOffset = -100;
		stage.colorTransform.greenOffset = -100;
		stage.colorTransform.blueOffset = -100;
	}
	agglomerate_fog_1.alpha = agglomerate_fog_2.alpha = agglomerate_fog_3.alpha = agglomerate_fog_4.alpha = 0.75;
	setCamFollow();
	FlxTween.num(0.7, 1, Conductor.getMeasuresInTime(12, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		defaultCamZoom = val;
	});
	FlxTween.num(100, 0, Conductor.getMeasuresInTime(5, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.smoothStepOut}, (val:Float) -> {
		blur_1.blur_size = [val, 0];
		blur_2.blur_size = [0, val];
	});
});

event.createStep(2080, () -> {
	camZoomingStrength = 0.75;
	FlxTween.num(0, 0.5, Conductor.getMeasuresInTime(6, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		flashSizes = val;
	});
});

event.createStep(2148, () -> {
	var pos = getStrumlineCamPosHxAvg([0, 1]);
	setCamFollow(pos.x, pos.y);
	defaultCamZoom = 0.6;
	camGameZoomLerp = 0.025;
});

event.createStep(2176, () -> {
	flashInOut(Conductor.getStepsInTime(16, Conductor.curChangeIndex) * 0.001, -1, Conductor.getStepsInTime(16, Conductor.curChangeIndex) * 0.001, 0xff000000);
	FlxTween.num(1, 0.75, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quintIn}, (val:Float) -> {
		defaultHudZoom = val;
	});
});

event.createStep(2192, () -> {
	flashInOut(Conductor.getStepsInTime(16, Conductor.curChangeIndex) * 0.001, -1, -1, 0xffffffff);
	FlxTween.num(defaultHudZoom, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quintIn}, (val:Float) -> {
		defaultHudZoom = val;
	});
	FlxTween.num(-360, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease: FlxEase.quintInOut}, (val:Float) -> {
		camHUD.angle = val;
	});
});

event.createStep(2208, () -> {
	camZoomingStrength = 1.5;
	camGameZoomLerp = 0.01;
	FlxTween.num(10, 0, 1, {}, (val:Float) -> {
		blur_1.blur_size = [val, 0];
		blur_2.blur_size = [0, val];
	});
	FlxTween.num(1.5, 1, 1, {}, (val:Float) -> {
		saturation.luminance_contrast = val;
	});
	FlxTween.num(-1, 0, 1, {ease: FlxEase.quartOut}, (val:Float) -> {
		distortion_amplification.strength = val;
	});
	defaultCamZoom = 0.65;
	flashSizes = 1;
	FlxTween.num(0.6, 0.8, Conductor.getMeasuresInTime(15, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		defaultCamZoom = val;
	});
	snowSprite.alpha = 1;
});

event.createStep(2456, () -> {
	flashInOut(Conductor.getStepsInTime(8, Conductor.curChangeIndex) * 0.001, -1, -1, 0xff000000);
});

event.createStep(2464, () -> {
	flash(1, 0xffffffff, camHUD, 0.6);
	blur_1.blur_size = [0, 0];
	blur_2.blur_size = [0, 0];
	setCamZoomMoment(0.75);
	FlxG.camera.zoom -= 0.1;
	var col = [232 / 255 * 0.7, 228 / 255 * 0.7, 255 / 255 * 0.7];
	shadow_optimization_licanis.color = col;
	dadShadow.shader.color = col;
	bfShadow.shader.color = col;
	for (stage in stage.stageSprites) {
		stage.colorTransform.redOffset = 0;
		stage.colorTransform.greenOffset = 0;
		stage.colorTransform.blueOffset = 0;
	}
	agglomerate_fog_1.alpha = agglomerate_fog_2.alpha = agglomerate_fog_3.alpha = agglomerate_fog_4.alpha = snowSprite.alpha = 0;
	FlxTween.num(0, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		background_flash.alpha = prospect_flash.alpha = 0;
	});
	camZoomingStrength = 0.75;
});

event.createStep(2476, () -> {
	setCamFollow();
	FlxG.camera.followLerp = 0.02;
	camGameZoomLerp = 0.04;
	defaultCamZoom = 0.9;
});

event.createStep(2604, () -> {
	defaultCamZoom = 0.9;
});

event.createStep(2716, () -> {
	FlxTween.num(1, 2.5, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {
		ease: FlxEase.quintIn,
		onComplete: () -> {
			mirror_repeat_effect.zoom = 1;
		}
	}, (val:Float) -> {
		mirror_repeat_effect.zoom = val;
	});
	FlxTween.num(0, 5, Conductor.getStepsInTime(4, Conductor.curChangeIndex) * 0.001, {
		ease: FlxEase.quintIn,
		onComplete: () -> {
			distortion_amplification.strength = 0;
	}}, (val:Float) -> {
		distortion_amplification.strength = val;
	});
});

event.createStep(2720, () -> {
	camZoomingInterval = 680;
	camZoomingStrength = 3;
	flashInOut(Conductor.getMeasuresInTime(2, Conductor.curChangeIndex) * 0.001, -1, 1000000, 0xff000000);
	flash(1, 0xffffffff, null, 0.6);
	FlxTween.num(1.5, 1, 1, {}, (val:Float) -> {
		saturation.luminance_contrast = val;
	});
	FlxTween.num(0, 50, Conductor.getMeasuresInTime(2, Conductor.curChangeIndex) * 0.001, {
		onComplete: () -> {
			blur_1.blur_size = [0, 0];
			blur_2.blur_size = [0, 0];
		}
	}, (val:Float) -> {
		blur_1.blur_size = [val, 0];
		blur_2.blur_size = [0, val];
	});
	var pos = getStrumlineCamPosHxAvg([0, 1]);
	setCamFollowMoment(pos.x, pos.y - 50);
	FlxTween.num(0.65, 0.5, Conductor.getMeasuresInTime(2, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		setCamZoomMoment(val);
	});
	FlxTween.num(1, 0, Conductor.getMeasuresInTime(3, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
		camHUD.alpha = val;
	});
});

function findTransparentParticle() {
	for (particle in snowParticle.members) {
		if (particle != null && particle.alpha == 0) {
			return particle;
		}
	}
	return null;
}

var b = 0;
function zoom() {
	b += 10;
	setCamZoomMoment(defaultCamZoom + 0.2);
	blur_1.blur_size = [b, 0];
	blur_2.blur_size = [0, b];
}

function bfCol() {
	var hueRandom = FlxG.random.float(0, 6.28318530718);
	hueShift.hueShift = [Math.cos(hueRandom), Math.sin(hueRandom)];
	hueShift_note.hueShift = hueShift.hueShift;
}