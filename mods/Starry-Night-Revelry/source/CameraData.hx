import flixel.math.FlxPoint;

// CameraData.hx

class CamPosData {
	public var pos:FlxPoint;

	public var amount:Int;

	public function new(pos:FlxPoint, amount:Int) {
		this.pos = pos;
		this.amount = amount;
	}

	public function put() {
		if(pos == null) return;
		pos.put();
		pos = null;
	}
}

class CamPos {
	public var offset:FlxPoint = FlxPoint.get(0, 0);

	public var followSize:Float = 12.5;
	public var followChars:Bool = true;
}

class CamZoom {
	public var zoomData:Array = [];
	public var zoomChars:Bool = false;

	public function create(length) {
		for (i in 0...(length ?? 2))
			zoomData[i] = new CamZoomData();
	}

	public function getZoom(target:Int) {
		var data = zoomData[target];
		return (data.zoom + data.zoomOffset) * data.zoomMultiplier;
	}


	public function setAllZoom(?zoom:Float) {
		for (data in zoomData)
			data.zoom = zoom ?? 1;
	}

	public function setTargetZoom(target:Int, ?zoom:Float) {
		zoomData[i].zoom = zoom ?? 1;
	}


	public function setAllZoomOffset(target:Int, ?offset:Float) {
		for (data in zoomData)
			data.zoomOffset = offset ?? 0;
	}

	public function setTargetZoomOffset(target:Int, ?offset:Float) {
		zoomData[i].zoomOffset = offset ?? 0;
	}


	public function setAllZoomMultiplier(target:Int, ?multiplier:Float) {
		for (data in zoomData)
			data.zoomMultiplier = multiplier ?? 1;
	}

	public function setTargetZoomMultiplier(target:Int, ?multiplier:Float) {
		zoomData[i].zoomMultiplier = multiplier ?? 1;
	}
}

class CamZoomData {
	public var zoom:Float;
	public var zoomOffset:Float;
	public var zoomMultiplier:Float;

	public function new(?zoom:Float, ?zoomOffset:Float, ?zoomMultiplier:Float) {
		this.zoom = zoom ?? 1;
		this.zoomOffset = zoomOffset ?? 0;
		this.zoomMultiplier = zoomMultiplier ?? 1;
	}
}

class AngleData {
	public var sizeOffset:Float = 1;
	public var angle:Float = 0;
	public var angleLerp:Float = 0;
	public var angleOffset:Float = 0;
	public var angleChars:Bool = true;
}