import flixel.math.FlxBasePoint;

static var camOffset:Array<Float> = [0, 0];

static var camOffsetSize:Float;
static var camFollowChars:Bool = true;

public var camAngle:Array = [1, 0, 0, 0];
public var camAngleChars:Bool = true;

var movement = new FlxBasePoint();
var camMove;

function create() {
	FlxG.camera.followLerp = 0.04;
	camOffsetSize = 12.5;
	camFollowChars = true;
	camOffset = [0, 0];
	camAngleChars = true;
}


function onCameraMove(camMoveEvent) {
	camMove = camMoveEvent;
	if (camFollowChars) {
		switch (camMoveEvent.strumLine.characters[0].animation.name) {
			case "singLEFT": movement.set(-camOffsetSize);
			case "singDOWN": movement.set(0, camOffsetSize);
			case "singUP": movement.set(0, -camOffsetSize);
			case "singRIGHT": movement.set(camOffsetSize);
			case "singLEFT-alt": movement.set(-camOffsetSize);
			case "singDOWN-alt": movement.set(0, camOffsetSize);
			case "singUP-alt": movement.set(0, -camOffsetSize);
			case "singRIGHT-alt": movement.set(camOffsetSize);
			default: movement.set();
		};

		camMoveEvent.position.x += movement.x + camOffset[0];
		camMoveEvent.position.y += movement.y + camOffset[1];
	} else camMoveEvent.cancel();
}


function postUpdate(elapsed:Float) {
	if (camAngleChars) {
		switch (camMove.strumLine.characters[0].animation.name) {
			case "singLEFT": camAngle[1] = -camAngle[0];
			case "singDOWN": camAngle[1] = -camAngle[0] / 5;
			case "singUP": camAngle[1] = camAngle[0] / 5;
			case "singRIGHT": camAngle[1] = camAngle[0];
			case "singLEFT-alt": camAngle[1] = -camAngle[0];
			case "singDOWN-alt": camAngle[1] = -camAngle[0] / 5;
			case "singUP-alt": camAngle[1] = camAngle[0] / 5;
			case "singRIGHT-alt": camAngle[1] = camAngle[0];
			default: camAngle[1] = 0;
		};
	}
	camAngle[2] = lerp(camAngle[2], camAngle[1], 1 / 60);
	FlxG.camera.angle = camAngle[2] + camAngle[3];
	// FlxG.camera.zoom = 0.1;
}




// public functions
public function getCamIndex(cam) {return FlxG.cameras.list.copy().indexOf(cam);}


public function addCamera(indexOf:Int, downscroll:Bool) {
	if (indexOf != null) {
		var cameras:Array<FlxCameras> = FlxG.cameras.list.copy();

		for (camera in cameras) FlxG.cameras.remove(camera, false);

		var cam = new HudCamera();
		cam.downscroll = downscroll;
		cam.bgColor = 0x00;
		cameras.insert(indexOf, cam);
		for (camera in cameras) FlxG.cameras.add(camera, camera == camGame);
		return cam;
	} else {
		var cam = new HudCamera();
		FlxG.cameras.add(cam, false);
		cam.bgColor = 0x00;
		return cam;
	}
}


public function flash(a:Float = 1, t:Float = 1) {
	colors1.alpha = a;
	FlxTween.tween(colors1, {alpha: 0}, t);
}


public function setFollowChars(Bool:Bool) {
	camAngleChars = Bool;
	camAngleFollowCharsPort = FlxG.camera.angle;
}


public function setCamFollow(x:Float, y:Float) {
	if (x != null && y != null) {
		camFollowChars = false;
		camFollow.setPosition(x, y);
	} else camFollowChars = true;
}

public function setCamFollowMoment(x:Float, y:Float) {
	if (x != null && y != null) {
		camFollowChars = false;
		camFollow.setPosition(x, y);
		FlxG.camera.scroll.set(x - center(FlxG.camera, 'x'), y - center(FlxG.camera, 'y'));
	} else camFollowChars = true;
}


public function addBfCamOffset(x, y) {boyfriend.cameraOffset.add(x, y);}
public function addGfCamOffset(x, y) {gf.cameraOffset.add(x, y);}
public function addDadCamOffset(x, y) {dad.cameraOffset.add(x, y);}


public function setCamZoomMoment(zoom:Float) {defaultCamZoom = FlxG.camera.zoom = zoom;}

public function addCameraZoom(GCZ:Float = 0.015, UICZ:Float = 0.03) {
	FlxG.camera.zoom += GCZ;
	camHUD.zoom += UICZ;
}