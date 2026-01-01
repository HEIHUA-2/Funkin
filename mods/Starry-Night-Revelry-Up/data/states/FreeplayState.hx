import haxe.Timer;
import haxe.Date;
import flixel.group.FlxSpriteGroup;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.util.FlxAxes;
import funkin.backend.utils.AudioAnalyzer;

var saturation:CustomShader = new CustomShader('saturation');
saturation.saturation = 1.1;
saturation.offset = 0.3;
saturation.multiply = 1.75;
saturation.luminance_contrast = 1;
FlxG.camera.addShader(saturation);

var bf:FunkinSprite = new FunkinSprite(900, 1000, Paths.image('menus/freeplaymenu/bf'));
bf.scale.set(2 / 3, 2 / 3);
bf.updateHitbox();
bf.offset.y -= 140;
bf.antialiasing = true;

var dad:FunkinSprite = new FunkinSprite(25, -1000, Paths.image('menus/freeplaymenu/stella'));
dad.scale.set(2 / 3, 2 / 3);
dad.updateHitbox();
dad.offset.y -= 90;
dad.antialiasing = true;

var dad_pd:FunkinSprite = new FunkinSprite(25, -1000, Paths.image('menus/freeplaymenu/stella_pd'));
dad_pd.scale.set(2 / 3, 2 / 3);
dad_pd.updateHitbox();
dad_pd.offset.y -= 90;
dad_pd.antialiasing = true;

var li_pd:FunkinSprite = new FunkinSprite(75, 1280, Paths.image('menus/freeplaymenu/li_pd'));
li_pd.scale.set(2 / 3, 2 / 3);
li_pd.updateHitbox();
li_pd.offset.y -= 90;
li_pd.antialiasing = true;

var border:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/freeplaymenu/border'));
border.scale.set(1.15, 1);
border.zoomFactor = 2;
border.antialiasing = false;

var dadTrail:FlxTrail = new FlxTrail(dad, null, 5, 16, 0.3, 0.069);
var bfTrail:FlxTrail = new FlxTrail(bf, null, 5, 16, 0.3, 0.069);
var dad_pdTrail:FlxTrail = new FlxTrail(dad_pd, null, 5, 16, 0.3, 0.069);
var li_pdTrail:FlxTrail = new FlxTrail(li_pd, null, 5, 16, 0.3, 0.069);

var leftBox:FlxBackdrop;
var rightBox:FlxBackdrop;

var audioLength = 1280 / 2;
var audioSprite = new FlxSpriteGroup();
var analyzer = new AudioAnalyzer(FlxG.sound.music, audioLength);
var samples;

function postCreate() {
	bg.destroy();

	for (icon in iconArray) icon.exists = icon.alive = false;

	leftBox = new FlxBackdrop(FlxGridOverlay.createGrid(20, 20, 340, 40, true, 0x33FFFFFF, 0x0), FlxAxes.Y);
	leftBox.x = 50;
	leftBox.velocity.y = 25;
	leftBox.blend = 0;
	insert(members.indexOf(grpSongs), leftBox);

	rightBox = new FlxBackdrop(FlxGridOverlay.createGrid(20, 20, 340, 40, true, 0x33FFFFFF, 0x0), FlxAxes.Y);
	rightBox.x = 895;
	rightBox.velocity.y = -25;
	rightBox.blend = 0;
	insert(members.indexOf(grpSongs), rightBox);

	var x = 0;
	var width = 1280 / audioLength;
	for (i in 0...audioLength) {
		var audioBox = new FunkinSprite(x, 720 / 2 - 0.5).makeGraphic(width, 1, 0xff000000);
		audioBox.antialiasing = false;
		audioBox.zoomFactor = 0;
		audioSprite.add(audioBox);
		x += width;
	}
	insert(members.indexOf(leftBox), audioSprite);
	audioSprite.alpha = 0.6;

	insert(members.indexOf(grpSongs), border);

	var bar_1 = new FunkinSprite(-100, -200 + 40).makeGraphic(2000, 200, 0xff000000);
	var bar_2 = new FunkinSprite(-100, 720 - 40).makeGraphic(2000, 200, 0xff000000);
	insert(members.indexOf(grpSongs), bar_1);
	insert(members.indexOf(grpSongs), bar_2);

	Timer.delay(() -> {
		insert(members.indexOf(grpSongs) - 3, bf);
		insert(members.indexOf(grpSongs) - 3, dad);
		insert(members.indexOf(grpSongs) - 3, dad_pd);
		insert(members.indexOf(grpSongs) - 3, li_pd);

		dadTrail.afterCache = afterCacheDad;
		insert(members.indexOf(dad), dadTrail);

		bfTrail.afterCache = afterCacheBF;
		insert(members.indexOf(bf), bfTrail);

		dad_pdTrail.afterCache = afterCacheDad_pd;
		insert(members.indexOf(dad_pd), dad_pdTrail);

		li_pdTrail.afterCache = afterCacheLi_pd;
		insert(members.indexOf(dad_pd), li_pdTrail);

		FlxTween.tween(bf, {y: 0}, 3, {ease: FlxEase.elasticOut});
		FlxTween.tween(dad, {y: 0}, 3, {ease: FlxEase.elasticOut});

		FlxTween.tween(dad_pd, {y: -20}, 3, {ease: FlxEase.elasticOut});
		FlxTween.tween(li_pd, {y: 260}, 3, {ease: FlxEase.elasticOut});

		for (trail in [dadTrail, bfTrail, dad_pdTrail, li_pdTrail]) {
			FlxTween.num(10, 5, 3, {ease: FlxEase.elasticOut}, function(val) {
				trail.delay = val / (60 * FlxG.elapsed);
			});
			FlxTween.tween(trail, {delay: 10}, 3, {ease: FlxEase.elasticOut});
		}
	}, 500);

	// for (text in [scoreText, diffText, coopText]) {
	// 	text.textField.antiAliasType = 0;
	// 	text.textField.sharpness = 400;
	// }

	var l = new FunkinSprite(-100, -100).makeGraphic(1280 + 200, 720 + 200, 0xff372e4d);
	l.alpha = 0.4;
	add(l);
}

var pd:Bool = false;
function onChangeSelection(e) {
	pd = songs[e.value].name == 'polar-day' ? true : false;
}

var _t:Float = 1;

var halfLength = audioLength >> 1;
var halfLengthPlusOne = halfLength;
var scaleMultiplier = 500;

var analyzerZoom;

function postUpdate(elapsed:Float) {
	if ((_t += elapsed) >= 1) {
		createFog();
		_t -= 1;
	}

	samples = analyzer.getLevels(
		FlxG.sound.music.time, 
		0.1,
		halfLengthPlusOne,
		samples,
		10 * elapsed,
		-90,
		0,
		80,
		22000
	);

	var sample, scaleValue, sprite, sprite_2;
	var audioLengths = audioLength - 1;
	var audioMembers = audioSprite.members;
	for (i in 0...halfLength) {
		sample = samples[i];
		scaleValue = sample * scaleMultiplier;

		sprite = audioMembers[i];
		sprite_2 = audioMembers[audioLengths - i];

		sprite.scale.y = sprite_2.scale.y = scaleValue;
		sprite.alpha = sprite_2.alpha = sample;
	}

	if (audioLength % 2 == 1) {
		sprite = audioMembers[halfLength];
		sprite.scale.y = samples[halfLength] * scaleMultiplier;
		sprite.alpha = samples[halfLength];
	}

	FlxG.camera.zoom = 0.95 + samples[64] * 0.05;

	// leftBox.color = rightBox.color = bg.color;

	for (n in grpSongs.members) n.screenCenter(FlxAxes.X);

	if (bfTrail == null) return;

	dadTrail.delay = bfTrail.delay = li_pdTrail.delay = dad_pdTrail.delay = 5 / (60 * elapsed);

	bf.angle = Math.sin(FlxG.game.ticks * 0.0025) * 2;
	dad.angle = Math.sin(FlxG.game.ticks * 0.002) * 2.5;
	dad_pd.angle = Math.sin(FlxG.game.ticks * 0.0015) * 2.2;
	li_pd.angle = Math.sin(FlxG.game.ticks * 0.00225) * 2.4;

	var alpha = pd ? 0 : 1;
	var alpha_pd = 1 - alpha;
	for (sprite in [dad, dadTrail])
		sprite.alpha = lerp(sprite.alpha, alpha, 0.1);

	for (sprite in [dad_pd, li_pd, dad_pdTrail, li_pdTrail])
		sprite.alpha = lerp(sprite.alpha, alpha_pd, 0.1);
}

function createFog() {
	FlxG.camera.bgColor = getEnvironmentColorCustom(0xffffffff, 0xff372e4d);

	var fog = new FunkinSprite(0, 0, Paths.image('menus/freeplaymenu/fog'));
	fog.zoomFactor = 0.5;
	fog.flipX = FlxG.random.bool();
	fog.flipY = FlxG.random.bool();
	fog.antialiasing = false;
	fog.color = 0x00000000;
	fog.alpha = 0;
	fog.addAnim('0', 'fog000' + FlxG.random.int(0, 4));
	fog.playAnim('0');
	insert(0, fog);

	var fogc = getEnvironmentColorCustom(0xff372e4d, 0xffffffff);
	FlxTween.tween(fog.scale, {x: 10, y: 10}, 20, {ease: FlxEase.sineIn});
	FlxTween.color(fog, 2, 0x00000000, fogc, {
		onComplete: () -> {
			FlxTween.color(fog, 18, fogc, 0x00000000, {
				ease: FlxEase.expoIn, onComplete: () -> {
				fog.destroy();
			}});
		}
	});
}

function getEnvironmentColorCustom(?dayColor:Int, ?nightColor:Int, ?sunriseStart:Float, ?sunriseEnd:Float, ?sunsetStart:Float, ?sunsetEnd:Float):Int
{
	dayColor ??= 0xFF87CEEB; nightColor ??= 0xFF191970; sunriseStart ??= 5.5; sunriseEnd ??= 7; sunsetStart ??= 18; sunsetEnd ??= 19.5;

	var now:Date = Date.now();
	var hours:Float = now.getHours() + now.getMinutes() / 60;

	var ratio:Float = 0;
	
	if (hours >= sunriseStart && hours < sunriseEnd)
		ratio = (hours - sunriseStart) / (sunriseEnd - sunriseStart);
	else if (hours >= sunriseEnd && hours < sunsetStart)
		ratio = 1;
	else if (hours >= sunsetStart && hours < sunsetEnd)
		ratio = 1 - (hours - sunsetStart) / (sunsetEnd - sunsetStart);
	else
		ratio = 0;

	var dayA:Int = (dayColor >> 24) & 0xFF;
	var dayR:Int = (dayColor >> 16) & 0xFF;
	var dayG:Int = (dayColor >> 8) & 0xFF;
	var dayB:Int = dayColor & 0xFF;
	
	var nightA:Int = (nightColor >> 24) & 0xFF;
	var nightR:Int = (nightColor >> 16) & 0xFF;
	var nightG:Int = (nightColor >> 8) & 0xFF;
	var nightB:Int = nightColor & 0xFF;

	var a:Int = Std.int(nightA + (dayA - nightA) * ratio);
	var r:Int = Std.int(nightR + (dayR - nightR) * ratio);
	var g:Int = Std.int(nightG + (dayG - nightG) * ratio);
	var b:Int = Std.int(nightB + (dayB - nightB) * ratio);

	a = CoolUtil.boundInt(a, 0, 255);
	r = CoolUtil.boundInt(r, 0, 255);
	g = CoolUtil.boundInt(g, 0, 255);
	b = CoolUtil.boundInt(b, 0, 255);

	return (a << 24) | (r << 16) | (g << 8) | b;
}

function afterCacheTrail(trailObj:Dynamic) {
	var baseScale = -0.45 + 1;
	var scaleIncrement = 0.1;

	var members = trailObj.members;

	for (i in 0...members.length) {
		var trail = members[i];
		var scaleValue = baseScale + (i * scaleIncrement);
		trail.scale.set(scaleValue, scaleValue);
	}
}

function afterCacheBF() {
  afterCacheTrail(bfTrail);
}

function afterCacheDad() {
  afterCacheTrail(dadTrail);
}

function afterCacheLi_pd() {
  afterCacheTrail(li_pdTrail);
}

function afterCacheDad_pd() {
  afterCacheTrail(dad_pdTrail);
}

function destroy() {
	bfTrail.destroy();
	dadTrail.destroy();

	FlxG.camera.bgColor = 0xff000000;
	FlxG.game.setFilters([]);
}