import flixel.math.FlxPoint;
import funkin.backend.utils.MathUtil;
import CameraData;

public var topBar:FunkinSprite = new FunkinSprite(0, -360).makeGraphic(1, 1, 0xff000000);
public var bottomBar:FunkinSprite = new FunkinSprite(0, 720).makeGraphic(1, 1, 0xff000000);

var topBarTween:FlxTween;
var bottomBarTween:FlxTween;

public var camBar:HudCamera;
public var camOther:HudCamera;

public var hitHealth = 0;
public var hitHealthSus = 0;
public var hitHealthMix = 0;

public var camData:CamPos = new CamPos();
public var zoomData:CamZoom = new CamZoom();
public var angleData:AngleData = new AngleData();

function create() {
	camBar = addCamera(getCamIndex(camHUD), false);
	camOther = addCamera(null, false);

	topBar.scale.set(1280, 360);
	topBar.updateHitbox();
	topBar.cameras = [camBar];
	topBar.scrollFactor.set();
	topBar.zoomFactor = 0;
	add(topBar);

	bottomBar.scale.set(1280, 360);
	bottomBar.updateHitbox();
	bottomBar.cameras = [camBar];
	bottomBar.scrollFactor.set();
	bottomBar.zoomFactor = 0;
	add(bottomBar);

	zoomData.create(strumLines.length);
}

function postCreate() {
	if (FlxG.save.data.starry_middle_scroll) {
		var i = 0;
		for (s in strumLines.members[1]) {
			s.x = -278 + 112 * i + 50 + (FlxG.width / 2);
			i += 1;
		}

		i = 0;
		for (s in strumLines.members[0]) {
			if (i < 2) {
				s.x = 82 + i * 112;
			} else {
				s.x = FlxG.width - 309 + (i - 2) * 112;
			}
			i += 1;
		}
	}

	for (strumLine in strumLines)
		for (strum in strumLine)
			strum.copyStrumAngle = false;
}

function onCameraMove(e) {
	var a = e.strumLine.characters[0].animation.name, p = e.position, c = camData.followChars,
		z = zoomData.zoomChars, o = angleData.angleChars, f = camData.followSize, x = camData.offset.x,
		y = camData.offset.y, s = angleData.sizeOffset, d = -1;

	if ((c | o) != 0 && a.length > 4) {
		var c4 = a.charCodeAt(4);
		d = (c4 == 76) ? 0 : (c4 == 68) ? 1 : (c4 == 85) ? 2 : (c4 == 82) ? 3 : -1;
	}
	
	if (d >= 0) {
		if (c) {
			var xs = [-f, 0, 0, f][d], ys = [0, f, -f, 0][d];
			p.x += xs + x; p.y += ys + y;
		}
		if (o) angleData.angleLerp = s * [-1, -0.2, 0.2, 1][d];
	} else if (o) {
		p.x += x; p.y += y;
		angleData.angleLerp = 0;
	}
	
	angleData.angle += (angleData.angleLerp + angleData.angleOffset - angleData.angle) * FlxG.elapsed * 1.570796;
	FlxG.camera.angle = angleData.angle;
	if (z) defaultCamZoom = zoomData.getZoom(curCameraTarget);
	if (!c) e.cancel();
}


function onNoteHit(event) {
	if (hitHealth == 0 && health <= hitHealthMix && hitHealthSus == 0 && event.note.strumLine == (!PlayState.opponentMode ? playerStrums : cpuStrums))
		return;

	var hitHealth = !event.note.isSustainNote ? hitHealth : hitHealthSus;
	health = MathUtil.max([health - hitHealth, hitHealthMix]);
}





// ---------------------------- Health Functions ----------------------------

public function setDadHitHealth(?n:Float, ?s:Float, ?m:Float) {
	if (n != null) {
		hitHealth = n;
		hitHealthSus = s ?? n;
	}
	if (m != null)
		hitHealthMix = m;
}




// ---------------------------- Event Functions ----------------------------

// 电影黑边移动
public function cinematicBars(?height:Float, ?time:Float, ?ease:FlxEase) {
	if (topBarTween != null && bottomBarTween != null)
		topBarTween.active = bottomBarTween.active = false;

	time ??= 0;
	height ??= 0;
	if (time > 0) {
		ease ??= FlxEase.quartOut;
		topBarTween = FlxTween.tween(topBar, {y: height - 360}, time, {ease: ease, onComplete: function(tween:FlxTween) {} });
		bottomBarTween = FlxTween.tween(bottomBar, {y: 720 - height}, time, {ease: ease, onComplete: function(tween:FlxTween) {} });
	} else {
		topBar.y = height - 360;
		bottomBar.y = 720 - height;
	}
}



public function colorRGBFloat(colorInt:Int):Array<Float> {
	return [
		((colorInt >> 16) & 0xFF) / 256.0,
		((colorInt >> 8) & 0xFF) / 256.0,
		(colorInt & 0xFF) / 256.0
	];
}

public function colorRGBAFloat(colorInt:Int):Array<Float> {
	return [
		((colorInt >> 16) & 0xFF) / 256.0,
		((colorInt >> 8) & 0xFF) / 256.0,
		(colorInt & 0xFF) / 256.0,
		((colorInt >> 24) & 0xFF) / 256.0
	];
}


public function colorRGB(colorInt:Int):Array {
	return [(colorInt >> 16) & 0xFF, (colorInt >> 8) & 0xFF, colorInt & 0xFF];
}


public function WRand(?min:Float, ?max:Float, ?multiplier:Float):Float {
	min ??= 0;
	max ??= 1;
	multiplier ??= 1;

	if (multiplier != 1)
		return min + (max - min) * Math.pow(1 - FlxG.random.float(0, 1), 1 / multiplier);
	else
		return FlxG.random.float(min, max);
}


public function center(obj, ?axis) {
	axis ??= 'xy';
	if (axis == 'x') return obj.width / 2;
	if (axis == 'y') return obj.height / 2;
	if (axis == 'xy') return [obj.width / 2, obj.height / 2];
}




// ---------------------------- Cam Functions ----------------------------

/**
 * 淡出闪光
 * @param cam 要提取位置的摄像机
 */
public function getCamIndex(cam) {return FlxG.cameras.list.copy().indexOf(cam);}


/**
 * 淡出闪光
 * @param indexOf 插入位置
 * @param downscroll 启用y轴反转
 */
public function addCamera(?indexOf:Int, ?downscroll:Bool) {
	var cam = new HudCamera();
	if (indexOf != null) {
		var cameras:Array<FlxCameras> = FlxG.cameras.list.copy();

		for (camera in cameras) FlxG.cameras.remove(camera, false);

		cameras.insert(indexOf, cam);
		for (camera in cameras) FlxG.cameras.add(camera, camera == camGame);
	} else {
		FlxG.cameras.add(cam, false);
	}

	cam.downscroll = downscroll;
	cam.bgColor = 0x00;
	return cam;
}

/**
 * 淡出闪光
 * @param fadeOutDuration 淡出时间
 * @param col 颜色
 * @param cam 相机
 * @param peakAlpha 峰值透明度
 * @param insertIndex 插入位置
 */
public function flash(?fadeOutDuration:Float, ?col:Int, ?cam:FlxCamera, ?peakAlpha:Float, ?insertIndex:Int) {
	final duration = fadeOutDuration != null ? fadeOutDuration : 1;
	final color = col != null ? col : 0xffffffff;
	final alphaStart = peakAlpha != null ? peakAlpha : 1;

	var flash = new FunkinSprite().makeGraphic(1, 1, color);
	flash.scale.set(FlxG.width, FlxG.height);
	flash.updateHitbox();
	flash.scale.set(FlxG.width * 2, FlxG.height * 2);
	flash.scrollFactor.set();
	flash.zoomFactor = 0;
	flash.alpha = alphaStart;

	if (cam != null) flash.cameras = [cam];

	if (insertIndex == null)
		add(flash);
	else
		insert(insertIndex, flash);

	FlxTween.num(alphaStart, 0, duration, {onComplete: function(tween:FlxTween) {
		flash.destroy();
	}}, (val:Float) -> {
		flash.alpha = val;
	});

	return flash;
}

/**
 * 带回调的自动淡入淡出闪光
 * @param fadeInDuration 淡入时间
 * @param fadeOutDuration 淡出时间
 * @param delay 淡入后延迟
 * @param color 颜色
 * @param cam 相机
 * @param insertIndex 插入位置
 * @param initialAlpha 初始透明度
 * @param peakAlpha 峰值透明度
 */
public function flashInOut(?inDuration:Float, ?outDuration:Float, ?delay:Float, ?color:Int, ?cam:FlxCamera, ?insertIndex:Int, ?initialAlpha:Float, ?peakAlpha:Float):Void {
	final col = color != null ? color : 0xffffffff;
	final alphaVal = peakAlpha != null ? peakAlpha : 1;
	final outDuration = outDuration;
	final delay = delay;
	initialAlpha ??= 0;
	
	final flash = new FunkinSprite();
	flash.makeGraphic(1, 1, col);
	flash.scale.set(FlxG.width, FlxG.height);
	flash.updateHitbox();
	flash.scale.set(FlxG.width * 2, FlxG.height * 2);
	flash.scrollFactor.set();
	flash.zoomFactor = 0;
	flash.alpha = initialAlpha;
	
	if (cam != null) flash.cameras = [cam];
	
	if (insertIndex == null) add(flash);
	else insert(insertIndex, flash);

	FlxTween.tween(flash, {alpha: alphaVal}, inDuration, {
		onComplete: function(tween:FlxTween) {
			if (delay > 0) {
				new FlxTimer().start(delay, function(tween:FlxTween) {
					fadeOutFlashWithCallback(flash, outDuration);
				});
			} else {
				fadeOutFlashWithCallback(flash, outDuration);
			}
		}
	});

	return flash;
}

function fadeOutFlashWithCallback(flash:FunkinSprite, duration:Float):Void {
	FlxTween.tween(flash, {alpha: 0}, duration, {
		ease: FlxEase.linear,
		onComplete: function(_) {
			if (flash != null && flash.exists) {
				remove(flash);
				flash.destroy();
			}
		}
	});
}


public function getStrumlineCamPosHx(strumLine:Int, ?pos:FlxPoint = null, ?ignoreInvisible:Bool = true):CamPosData {
	return getCharactersCamPosHx(strumLines.members[strumLine].characters, pos, ignoreInvisible);
}

public function getStrumlineCamPosHxAvg(strumLine:Array<Int>, ?pos:FlxPoint = null, ?ignoreInvisible:Bool = true):CamPosData {
	var n = 0;
	var camPos = FlxPoint.get();
	for (i in strumLine)
	{
		var pos = getCharactersCamPosHx(strumLines.members[i].characters, pos, ignoreInvisible);
		camPos.x += pos.pos.x;
		camPos.y += pos.pos.y;
		n++;
	}
	camPos.x /= n;
	camPos.y /= n;
	return camPos;
}

public function getCharactersCamPosHx(chars:Array<Character>, ?pos:FlxPoint = null, ?ignoreInvisible:Bool = true):CamPosData {
	if (pos == null) pos = FlxPoint.get();
	var amount = 0;
	for(c in chars) {
		if (c == null || (ignoreInvisible && !c.visible)) continue;
		var cpos = c.getCameraPosition();
		pos.x += cpos.x;
		pos.y += cpos.y;
		amount++;
		//cpos.put(); // not actually in the pool, so no need
	}
	if (amount > 0) {
		pos.x /= amount;
		pos.y /= amount;
	}
	return new CamPosData(pos, amount);
}


public function setFollowChars(Bool:Bool) {
	angleData.angleChars = Bool;
	camAngleFollowCharsPort = FlxG.camera.angle;
}


public function setCamFollowMomentNoChars(?x:Float, ?y:Float) {
	if (x != null && y != null) {
		camFollow.setPosition(x, y);
		FlxG.camera.scroll.set(x - center(FlxG.camera, 'x'), y - center(FlxG.camera, 'y'));
	}
}

public function setCamFollow(?x:Float, ?y:Float) {
	if (x != null && y != null) {
		camData.followChars = false;
		camFollow.setPosition(x, y);
	} else camData.followChars = true;
}

public function setCamFollowMoment(?x:Float, ?y:Float) {
	if (x != null && y != null) {
		camData.followChars = false;
		camFollow.setPosition(x, y);
		FlxG.camera.scroll.set(x - center(FlxG.camera, 'x'), y - center(FlxG.camera, 'y'));
	} else camData.followChars = true;
}

public function setCamFollowMomentNoCamFollow(?x:Float, ?y:Float) {
	if (x != null && y != null) {
		camData.followChars = false;
		camFollow.setPosition(x, y);
		FlxG.camera.scroll.set(x - center(FlxG.camera, 'x'), y - center(FlxG.camera, 'y'));
	} else camData.followChars = true;
}

public function addBfCamOffset(x, y) {boyfriend.cameraOffset.add(x, y);}
public function addGfCamOffset(x, y) {gf.cameraOffset.add(x, y);}
public function addDadCamOffset(x, y) {dad.cameraOffset.add(x, y);}


public function setCamZoomMoment(zoom:Float) {defaultCamZoom = FlxG.camera.zoom = zoom;}

public function addCameraZoom(?GCZ:Float, ?UICZ:Float) {
	FlxG.camera.zoom += GCZ ?? 0.015;
	camHUD.zoom += UICZ ?? 0.03;
}
// 全都是史