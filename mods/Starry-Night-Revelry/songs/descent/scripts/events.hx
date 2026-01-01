var cam = true;
var nnn = 0;

var colorShader:CustomShader;
var colorShader1:CustomShader;

var colors2:FunkinSprite;
var colors3:FunkinSprite;
var colors4:FunkinSprite;

var vcrshader:CustomShader;
var mirrorRepeatEffect:CustomShader;
var saturation:CustomShader;

function onPostStartCountdown() {
	introSprites = [null];
	introSounds = [null];
	Conductor.songPosition = 0;
}


function postCreate() {
	setDadHitHealth(0.03, 0.01, 0.05);

	colors2=new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xff000000);
	colors2.scale.set(1280 + 200, 720 + 200);
	colors2.updateHitbox();
	colors2.scrollFactor.set();
	colors2.zoomFactor = 0;
	colors2.alpha = 0;
	colors2.cameras = [camOther];
	add(colors2);

	colors3=new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xff000000);
	colors3.scale.set(1280 + 200, 720 + 200);
	colors3.updateHitbox();
	colors3.scrollFactor.set();
	colors3.zoomFactor = 0;
	colors3.alpha = 0;
	insert(members.indexOf(dad), colors3);
	
	colors4=new FunkinSprite(-100, -100).makeGraphic(1, 1, 0xffffffff);
	colors4.scale.set(1280 + 200, 720 + 200);
	colors4.updateHitbox();
	colors4.scrollFactor.set();
	colors4.zoomFactor = 0;
	colors4.alpha = 0;
	insert(members.indexOf(dad), colors4);
	
	vcrshader = shaderQuality('vcr', [FlxG.game]);
	vcrshader.amount = 0;

	mirrorRepeatEffect = new CustomShader('mirror_repeat_effect');
	mirrorRepeatEffect.x = 0;
	mirrorRepeatEffect.y = 0;
	mirrorRepeatEffect.zoom = 1;
	mirrorRepeatEffect.angle = 0;
	if (FlxG.save.data.starry_mirror_wrap_transform) FlxG.camera.addShader(mirrorRepeatEffect);

	saturation = new CustomShader('saturation');
	saturation.saturation = 1.1;
	saturation.offset = 0.25;
	saturation.multiply = 2;
	saturation.luminance_contrast = 1;
	FlxG.camera.addShader(saturation);
}


function onStartSong() {
	FlxG.camera.scroll.set(camFollow.x - FlxG.width / 2, camFollow.y - FlxG.height / 2);
	FlxTween.num(0.7, 0.9, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2, {ease:FlxEase.quartOut}, (val:Float) -> {
		FlxG.camera.zoom = val;
	});
	defaultCamZoom = 0.9;
}


function stepHit(step:Int) {
	switch (step) {
	case 34:
		defaultCamZoom += 0.05;
	case 36:
		defaultCamZoom += 0.05;
	case 40|44:
		defaultCamZoom -= 0.05;
	case 56:
		defaultCamZoom += 0.05;
	case 58:
		defaultCamZoom -= 0.05;
	case 60:
		defaultCamZoom += 0.05;
	case 62|66|68:
		defaultCamZoom -= 0.05;
	case 72|76:
		defaultCamZoom += 0.05;
	case 34+64:
		defaultCamZoom += 0.05;
	case 36+64:
		defaultCamZoom += 0.05;
	case 40+64|44+64:
		defaultCamZoom -= 0.05;
	case 56+64:
		defaultCamZoom += 0.05;
	case 58+64:
		defaultCamZoom -= 0.05;
	case 60+64:
		defaultCamZoom += 0.05;
	case 62+64|66+64|68+64:
		defaultCamZoom -= 0.05;
	case 72+64|76+64:
		defaultCamZoom += 0.05;
	case 144:
		defaultCamZoom = 0.75;
	case 156|168:
		defaultCamZoom += 0.1;
	case 176:
		defaultCamZoom -= 0.1;
	case 180:
		defaultCamZoom += 0.05;
	case 184:
		defaultCamZoom -= 0.05;
	case 188|192:
		defaultCamZoom += 0.05;
	case 196|200:
		defaultCamZoom -= 0.05;
	case 204:
		defaultCamZoom += 0.1;
	case 212:
		defaultCamZoom += 0.05;
	case 220:
		defaultCamZoom += 0.1;
	case 224:
		defaultCamZoom += 0.1;
	case 232|235|238:
		defaultCamZoom -= 0.05;
	case 224:
		defaultCamZoom += 0.1;
	case 248:
		defaultCamZoom += 0.1;
	case 256:
		defaultCamZoom -= 0.1;
	case 264:
		defaultCamZoom += 0.05;
	case 272:
		defaultCamZoom = 0.9;
	case 280:
		defaultCamZoom += 0.05;
	case 284:
		defaultCamZoom -= 0.05;
	case 286:
		defaultCamZoom -= 0.05;
	case 288:
		defaultCamZoom += 0.05;
	case 296:
		defaultCamZoom += 0.05;
	case 300:
		defaultCamZoom -= 0.1;
	case 304:
		defaultCamZoom += 0.1;
	case 312:
		defaultCamZoom += 0.1;
	case 316:
		defaultCamZoom -= 0.1;
	case 320:
		FlxTween.num(0, 46, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 8 * 0.625, {ease:FlxEase.quartIn}, (val:Float) -> {
			mirrorRepeatEffect.x = val * val;
		});
		FlxTween.num(mirrorRepeatEffect.zoom, 10, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 8 * 0.625, {ease:FlxEase.quartIn}, (val:Float) -> {
			mirrorRepeatEffect.zoom = val;
		});
		FlxTween.num(0, 5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 8 * 0.625, {ease:FlxEase.quartIn}, (val:Float) -> {
			vcrshader.amount = val;
		});
		FlxTween.num(FlxG.camera.zoom, 1.75, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 5 - 0.035, {ease:FlxEase.sineIn}, (val:Float) -> {
			FlxG.camera.zoom = val;
		});
	case 384|392|396|398|400:
		colors2.alpha += 0.2;
	case 416:
		FlxTween.num(colors2.alpha, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2 - 0.035, {}, (val:Float) -> {
			colors2.alpha = val;
		});
		FlxTween.num(-46, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2 - 0.035, {ease:FlxEase.quartOut}, (val:Float) -> {
			mirrorRepeatEffect.x = val;
		});
		FlxTween.num(mirrorRepeatEffect.zoom, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2 - 0.035, {ease:FlxEase.cubicOut}, (val:Float) -> {
			mirrorRepeatEffect.zoom = val;
		});
		FlxTween.num(vcrshader.amount, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 448:
		setCamZoomMoment(0.9);
		mirrorRepeatEffect.x = 0;
		vcrshader.amount = 0;
	case 460:
		defaultCamZoom += 0.05;
	case 472:
		defaultCamZoom += 0.05;
	case 496:
		defaultCamZoom -= 0.05;
	case 500:
		defaultCamZoom -= 0.05;
	case 504:
		defaultCamZoom += 0.05;
	case 508:
		defaultCamZoom += 0.05;
	case 520:
		defaultCamZoom += 0.05;
	case 522:
		defaultCamZoom -= 0.05;
	case 524:
		defaultCamZoom += 0.05;
	case 536:
		defaultCamZoom -= 0.05;
	case 538:
		defaultCamZoom += 0.05;
	case 540:
		defaultCamZoom += 0.05;
	case 544:
		defaultCamZoom = 0.9;
	case 552:
		defaultCamZoom += 0.075;
	case 560:
		defaultCamZoom -= 0.075;
	case 568|572:
		defaultCamZoom += 0.1;
	case 448+128:
		defaultCamZoom = 0.9;
	case 460+128:
		defaultCamZoom += 0.05;
	case 472+128:
		defaultCamZoom += 0.05;
	case 496+128:
		defaultCamZoom -= 0.05;
	case 500+128:
		defaultCamZoom -= 0.05;
	case 504+128:
		defaultCamZoom += 0.05;
	case 508+128:
		defaultCamZoom += 0.05;
	case 520+128:
		defaultCamZoom += 0.05;
	case 522+128:
		defaultCamZoom -= 0.05;
	case 524+128:
		defaultCamZoom += 0.05;
	case 536+128:
		defaultCamZoom -= 0.05;
	case 538+128:
		defaultCamZoom += 0.05;
	case 540+128:
		defaultCamZoom += 0.05;
	case 544+128:
		defaultCamZoom = 0.9;
	case 552+128:
		defaultCamZoom += 0.075;
	case 560+128:
		defaultCamZoom -= 0.075;
	case 568+128|572+128:
		defaultCamZoom -= 0.1;
	case 704:
		defaultCamZoom = 0.9;
		cinematicBars(100, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2);
		FlxTween.num(FlxG.camera.zoom, 1.2, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 4 - 0.035, {}, (val:Float) -> {
			FlxG.camera.zoom = val;
		});
	case 768:
		cinematicBars(0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001);
	case 772|778|784:
		defaultCamZoom += 0.05;
	case 790|796|804:
		defaultCamZoom -= 0.05;
	case 810|816|822|828|830:
		defaultCamZoom += 0.05;
	case 832:
		defaultCamZoom = 0.9;
	case 836:
		defaultCamZoom += 0.05;
	case 840:
		defaultCamZoom -= 0.05;
	case 844:
		defaultCamZoom += 0.05;
	case 848:
		defaultCamZoom -= 0.05;
	case 856|860|864|868:
		defaultCamZoom += 0.05;
	case 872:
		defaultCamZoom -= 0.1;
	case 874|876:
		defaultCamZoom += 0.05;
	case 880:
		defaultCamZoom = 0.9;
	case 836+64:
		defaultCamZoom += 0.05;
	case 840+64:
		defaultCamZoom -= 0.05;
	case 844+64:
		defaultCamZoom += 0.05;
	case 848+64:
		defaultCamZoom -= 0.05;
	case 856+64|860+64|864+64|868+64:
		defaultCamZoom += 0.05;
	case 872+64:
		defaultCamZoom -= 0.1;
	case 874+64|876+64:
		defaultCamZoom += 0.05;
	case 880+64:
		defaultCamZoom = 0.9;
	case 960:
		defaultCamZoom += 0.1;
		FlxTween.num(0, 0.5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
			colors3.alpha = val;
		});
	case 972:
		defaultCamZoom += 0.1;
	case 984:
		defaultCamZoom += 0.05;
	case 992:
		defaultCamZoom -= 0.1;
	case 1000:
		defaultCamZoom += 0.05;
	case 1016:
		defaultCamZoom -= 0.1;
	case 1020|1024|1028|1032:
		defaultCamZoom += 0.05;
	case 1036:
		defaultCamZoom -= 0.1;
	case 1040:
		defaultCamZoom += 0.075;
	case 1044:
		defaultCamZoom -= 0.075;
	case 1048:
		defaultCamZoom += 0.075;
	case 1052:
		defaultCamZoom -= 0.075;
	case 1056:
		defaultCamZoom += 0.1;
	case 1062|1068:
		defaultCamZoom -= 0.05;
	case 1072:
		defaultCamZoom += 0.1;
	case 1080:
		defaultCamZoom += 0.05;
	case 1088:
		defaultCamZoom = 1;
	case 1092|1096:
		defaultCamZoom += 0.05;
	case 1100:
		defaultCamZoom -= 0.05;
	case 1104:
		defaultCamZoom = 0.95;
	case 1112:
		defaultCamZoom += 0.1;
	case 1120|1124:
		defaultCamZoom -= 0.05;
	case 1128|1136:
		defaultCamZoom += 0.075;
	case 1144|1148:
		defaultCamZoom -= 0.05;
	case 1152|1156|1160:
		defaultCamZoom += 0.075;
	case 1164|1168|1172:
		defaultCamZoom -= 0.075;
	case 1176:
		defaultCamZoom += 0.075;
	case 1180:
		defaultCamZoom -= 0.075;
	case 1184:
		defaultCamZoom = 0.9;
	case 1200:
		defaultCamZoom += 0.075;
	case 972+256:
		defaultCamZoom += 0.1;
	case 984+256:
		defaultCamZoom += 0.05;
	case 992+256:
		defaultCamZoom -= 0.1;
	case 1000+256:
		defaultCamZoom += 0.05;
	case 1016+256:
		defaultCamZoom -= 0.1;
	case 1020+256|1024+256|1028+256|1032+256:
		defaultCamZoom += 0.05;
	case 1036+256:
		defaultCamZoom -= 0.1;
	case 1040+256:
		defaultCamZoom += 0.075;
	case 1044+256:
		defaultCamZoom -= 0.075;
	case 1048+256:
		defaultCamZoom += 0.075;
	case 1052+256:
		defaultCamZoom -= 0.075;
	case 1056+256:
		defaultCamZoom += 0.1;
	case 1062+256|1068+256:
		defaultCamZoom -= 0.05;
	case 1072+256:
		defaultCamZoom += 0.1;
	case 1080+256:
		defaultCamZoom += 0.05;
	case 1088+256:
		defaultCamZoom = 1;
	case 1092+256|1096+256:
		defaultCamZoom += 0.05;
	case 1100+256:
		defaultCamZoom -= 0.05;
	case 1104+256:
		defaultCamZoom = 0.95;
	case 1112+256:
		defaultCamZoom += 0.1;
	case 1120+256|1124+256:
		defaultCamZoom -= 0.05;
	case 1128+256|1136+256:
		defaultCamZoom += 0.075;
	case 1144+256|1148+256:
		defaultCamZoom -= 0.05;
	case 1152+256|1156+256|1160+256:
		defaultCamZoom += 0.075;
	case 1164+256|1168+256|1172+256:
		defaultCamZoom -= 0.075;
	case 1176+256:
		defaultCamZoom += 0.075;
	case 1180+256:
		defaultCamZoom -= 0.075;
	case 1184+256:
		defaultCamZoom = 0.9;
	case 1445|1461:
		FlxTween.num(FlxG.camera.zoom, FlxG.camera.zoom + 0.2, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 0.1875, {ease:FlxEase.sineOut}, (val:Float) -> {
			FlxG.camera.zoom = val;
		});
	case 1464:
		defaultCamZoom += 0.15;
		FlxTween.num(vcrshader.amount, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2 - 0.035, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 1472:
		FlxTween.num(vcrshader.amount, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2, {ease:FlxEase.quartOut}, (val:Float) -> {
			vcrshader.amount = val;
		});
		defaultCamZoom = 0.9;
		FlxTween.num(0.5, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
			colors3.alpha = val;
		});
	case 1548|1564|1576:
		defaultCamZoom += 0.05;
	case 1580:
		defaultCamZoom -= 0.1;
	case 1592|1596:
		defaultCamZoom += 0.05;
	case 1548+128|1564+128|1576+128:
		defaultCamZoom += 0.05;
	case 1580+128:
		defaultCamZoom -= 0.1;
	case 1712:
		FlxTween.num(vcrshader.amount, 5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 2, {}, (val:Float) -> {
			vcrshader.amount = val;
		});
		FlxTween.num(mirrorRepeatEffect.zoom, 5, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 0.75 - 0.035, {ease:FlxEase.quartOut}, (val:Float) -> {
			mirrorRepeatEffect.zoom = val;
		});
		FlxTween.num(mirrorRepeatEffect.angle, 360 * 2, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {ease:FlxEase.quartIn}, (val:Float) -> {
			mirrorRepeatEffect.angle = val;
		});
	case 1592+128:
		defaultCamZoom += 0.05;
	case 1596+128:
		defaultCamZoom += 0.05;
		FlxTween.num(mirrorRepeatEffect.zoom, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4, {ease:FlxEase.sineIn}, (val:Float) -> {
			mirrorRepeatEffect.zoom = val;
		});
		FlxTween.num(vcrshader.amount, 0, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 / 4, {ease:FlxEase.sineIn}, (val:Float) -> {
			vcrshader.amount = val;
		});
	case 1728:
		defaultCamZoom = 0.9;
	case 1736:
		defaultCamZoom += 0.075;
	case 1744:
		defaultCamZoom -= 0.075;
	case 1752:
		defaultCamZoom += 0.075;
	case 1760|1763|1766:
		defaultCamZoom += 0.05;
	case 1770:
		defaultCamZoom -= 0.075;
	case 1776:
		defaultCamZoom -= 0.05;
	case 1782:
		defaultCamZoom += 0.075;
	case 1784:
		defaultCamZoom -= 0.05;
	case 1790:
		defaultCamZoom += 0.075;
	case 1728+64:
		defaultCamZoom = 0.9;
	case 1736+64:
		defaultCamZoom += 0.075;
	case 1744+64:
		defaultCamZoom -= 0.075;
	case 1752+64:
		defaultCamZoom += 0.075;
	case 1760+64|1763+64|1766+64:
		defaultCamZoom += 0.05;
	case 1770+64:
		defaultCamZoom -= 0.075;
	case 1776+64:
		defaultCamZoom -= 0.05;
	case 1782+64:
		defaultCamZoom += 0.075;
	case 1784+64:
		defaultCamZoom -= 0.05;
	case 1790+64:
		defaultCamZoom += 0.075;
	case 1856:
		defaultCamZoom -= 0.1;
	case 1860|1864:
		defaultCamZoom += 0.05;
	case 1866:
		defaultCamZoom -= 0.05;
	case 1868:
		defaultCamZoom += 0.05;
	case 1870:
		defaultCamZoom -= 0.05;
	case 1872|1874:
		defaultCamZoom += 0.05;
	case 1876|1878:
		defaultCamZoom -= 0.05;
	case 1880:
		defaultCamZoom += 0.05;
	case 1882:
		defaultCamZoom -= 0.05;
	case 1884|1886|1888|1904:
		defaultCamZoom += 0.05;
	case 1912:
		defaultCamZoom -= 0.1;
	case 1856+64:
		defaultCamZoom -= 0.1;
	case 1860+64|1864+64:
		defaultCamZoom += 0.05;
	case 1866+64:
		defaultCamZoom -= 0.05;
	case 1868+64:
		defaultCamZoom += 0.05;
	case 1870+64:
		defaultCamZoom -= 0.05;
	case 1872+64|1874+64:
		defaultCamZoom += 0.05;
	case 1876+64|1878+64:
		defaultCamZoom -= 0.05;
	case 1880+64:
		defaultCamZoom += 0.05;
	case 1882+64:
		defaultCamZoom -= 0.05;
	case 1884+64|1886+64|1888+64|1904+64:
		defaultCamZoom += 0.05;
	case 1912+64:
		defaultCamZoom -= 0.1;
	case 1984:
		defaultCamZoom = 0.9;
	case 2032|2038|2044:
		defaultCamZoom += 0.05;
	case 1984+64:
		defaultCamZoom = 0.9;
	case 2032+64|2038+64|2044+64:
		defaultCamZoom += 0.05;
	case 2112:
		defaultCamZoom = 0.9;
	case 2116:
		defaultCamZoom += 0.05;
	case 2120|2124:
		defaultCamZoom -= 0.05;
	case 2128|2136:
		defaultCamZoom += 0.05;
	case 2140|2144:
		defaultCamZoom -= 0.05;
	case 2148:
		defaultCamZoom += 0.05;
	case 2152:
		defaultCamZoom -= 0.05;
	case 2156:
		defaultCamZoom += 0.05;
	case 2160:
		defaultCamZoom -= 0.05;
	case 2112+64:
		defaultCamZoom = 0.9;
	case 2116+64:
		defaultCamZoom += 0.05;
	case 2120+64|2124+64:
		defaultCamZoom -= 0.05;
	case 2128+64|2136+64:
		defaultCamZoom += 0.05;
	case 2140+64|2144+64:
		defaultCamZoom -= 0.05;
	case 2148+64:
		defaultCamZoom += 0.05;
	case 2152+64:
		defaultCamZoom -= 0.05;
	case 2156+64:
		defaultCamZoom += 0.05;
	case 2160+64:
		defaultCamZoom -= 0.05;
		FlxTween.num(0, 0.75, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 - 0.035, {}, (val:Float) -> {
			colors4.alpha = val;
		});
	case 2240:
		camHUD.alpha = comboRatingSprites.alpha = healthbarNew.alpha = healthbarBGNew.alpha = scoreTxt.alpha = missesTxt.alpha = accuracyTxt.alpha = iconP1.alpha = iconP2.alpha = 0.001;
		camZoomingInterval = 114514;
		for(stage in stage.stageSprites) stage.alpha = 0;

		colors4.alpha = 1;
		fog.alpha = 0;
		fog2.alpha = 0;

		boyfriend.alpha = 0;
		dad.alpha = 0;

		setCamFollow(450,350);
		setCamZoomMoment(0.3);

		FlxG.game.setFilters([]);
		camGame.setFilters([]);
		camHurtNote.setFilters([]);

		var directionalBlur = new CustomShader('directional_bloom');

		camGame.addShader(directionalBlur);
		case 2280:
			FlxTween.num(0, 0.6, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 1.5 - 0.035, {}, (val:Float) -> {
				camHUD.alpha = val;
			});
			FlxTween.num(0.275, 1.2, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 41.5 - 0.035, {}, (val:Float) -> {
				FlxG.camera.zoom = defaultCamZoom = val;
			});
		case 2304:
		var colorShader = new CustomShader('color');
		colorShader.a = 1;
		boyfriend.shader = colorShader;

		var colorShader1 = new CustomShader('color');
		colorShader1.a = 1;
		dad.shader = colorShader1;

		colorShader.c = colorRGBFloat(0xff1A9FC7);
		colorShader1.c = colorRGBFloat(0xff2d9adf);

		FlxTween.num(0, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001, {}, (val:Float) -> {
			boyfriend.alpha = dad.alpha = val;
		});
	case 2624:
		camData.followChars = true;
		camData.offset.y += 25;
	case 2944:
		camData.offset.y -= 25;
		camHUD.alpha = comboRatingSprites.alpha = healthbarNew.alpha = healthbarBGNew.alpha = scoreTxt.alpha = missesTxt.alpha = accuracyTxt.alpha = iconP1.alpha = iconP2.alpha = 1;
		FlxTween.num(defaultCamZoom, 0.8, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 2, {ease:FlxEase.quartOut}, (val:Float) -> {
			FlxG.camera.zoom = defaultCamZoom = val;
		});
		for(stage in stage.stageSprites) stage.alpha = 1;
		camGame.setFilters([]);
		colors4.alpha = 0;
		boyfriend.shader = null;
		dad.shader = null;
	case 2984:
		FlxTween.num(0, 1, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 1.5, {}, (val:Float) -> {
			colors2.alpha = val;
		});
	}
}


function postUpdate(elapsed:Float)
	vcrshader.iTime = FlxG.game.ticks * 0.001;