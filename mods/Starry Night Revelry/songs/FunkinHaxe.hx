static var Bar1:FunkinSprite;
static var Bar2:FunkinSprite;

static var colors:FunkinSprite;
static var colors1:FunkinSprite;
static var colors2:FunkinSprite;

var Bars1:FlxTween;
var Bars2:FlxTween;

static var camBar:HudCamera;
static var camOther:HudCamera;

function create() {
	camBar = addCamera(getCamIndex(camHUD), false);
	camOther = addCamera(null, false);

	colors2 = new FunkinSprite().makeGraphic(1, 1, 0xff000000);
	colors2.scale.set(1280, 720);
	colors2.updateHitbox();
	colors2.scrollFactor.set();
	colors2.zoomFactor = 0;
	colors2.alpha = 0;
	colors2.cameras = [camOther];
	add(colors2);

	colors1 = new FunkinSprite().makeGraphic(1, 1, 0xffffffff);
	colors1.scale.set(1280, 720);
	colors1.updateHitbox();
	colors1.cameras = [camBar];
	colors1.scrollFactor.set();
	colors1.zoomFactor = 0;
	colors1.alpha = 0;
	add(colors1);

	Bar1 = new FunkinSprite(0, -360).makeGraphic(1, 1, 0xff000000);
	Bar1.scale.set(1280, 360);
	Bar1.updateHitbox();
	Bar1.cameras = [camBar];
	Bar1.scrollFactor.set();
	Bar1.zoomFactor = 0;
	add(Bar1);

	Bar2 = new FunkinSprite(0, 720).makeGraphic(1, 1, 0xff000000);
	Bar2.scale.set(1280, 360);
	Bar2.updateHitbox();
	Bar2.cameras = [camBar];
	Bar2.scrollFactor.set();
	Bar2.zoomFactor = 0;
	add(Bar2);

	colors = new FunkinSprite().makeGraphic(1, 1, 0xff000000);
	colors.scale.set(1280, 720);
	colors.updateHitbox();
	colors.cameras = [camBar];
	colors.scrollFactor.set();
	colors.zoomFactor = 0;
	colors.alpha = 0;
	add(colors);
}

function onPostStageCreation(event) {
	trace(event);
}

//黑边移动
public function cinematicBars(height:Float=0, time:Float=1) {
	if (Bars1 != null && Bars2 != null)
		Bars1.active = Bars2.active = false;

	Bars1 = FlxTween.tween(Bar1, {y: height - 360}, time, {ease: FlxEase.quartOut, onComplete: function(tween:FlxTween) {} });
	Bars2 = FlxTween.tween(Bar2, {y: 720 - height}, time, {ease: FlxEase.quartOut, onComplete: function(tween:FlxTween) {} });
}


public function stepTime(number:Float):Float {
	return 60 / Conductor.bpm * number / 4;
}


public function minmix(n:Float, min:Float, mix:Float):Float {
	if (n < mix && n > min) {
		return n;
	} else {
	if (n > mix) return mix;
	if (n < min) return min;
	}
}


public function colorRGBFloat(colorInt:Int):Array {
	// 分离RGB成分
	var r:Int = (colorInt >> 16) & 0xFF;
	var g:Int = (colorInt >> 8) & 0xFF;
	var b:Int = colorInt & 0xFF;

	return [r / 255, g / 255, b / 255];
}


public function colorRGB(colorInt:Int):Array {
	return [(colorInt >> 16) & 0xFF, (colorInt >> 8) & 0xFF, colorInt & 0xFF];
}


public function WRand(min:Float, max:Float, multiplier:Float):Float {
	if (multiplier != 1)
		return min + (max - min) * Math.pow(1 - FlxG.random.float(0, 1), 1 / multiplier);
	else
		return FlxG.random.float(min, max);
}


public function abs(n:Float) {return (n > 0) ? n : -n;}


// 有效的加载图片，加载完成后生产贴图不会产生像PE那样的卡顿
public function precacheImage(image) {
	var precache = new FunkinSprite().loadGraphic(Paths.image(image));
	precache.scrollFactor.set();
	precache.zoomFactor = 0;
	precache.alpha = 0.001;
	add(precache);

	FlxTween.num(0, 1, 0.0001, {}, (val:Float) => {
		if (val == 1)
			image.destroy();
	});
}


public function center(obj, axis) {
	if (axis == null) axis = 'x';

	if (axis == 'x') return obj.width / 2;
	if (axis == 'y') return obj.height / 2;
	if (axis == 'xy') return [obj.width / 2, obj.height / 2];
}


public function getStageIndex(stage) {
	return members.indexOf(stage.stageSprites[stage]);
}
// 全都是史