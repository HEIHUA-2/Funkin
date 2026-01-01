import utils.StringUtil;

class SnowShader extends FlxBasic {
	public var shader:CustomShader;

	public var camera:FlxCamera = FlxG.camera;

	public var snowSpeed:Float = 1;

	var StringUtil:StringUtil = new StringUtil();

	public function new() {
		super();

		shader = new CustomShader('polar-day/snow');
		shader.fragmentPrefix = '
			#define SNOW_QUALITY ' + StringUtil.toGLSLFloat(1 / (FlxG.save.data.starry_snow_quality * 0.5)) + '
		';
		shader.iTime = 0;
		shader.snowAmount = 1;
		shader.gradual = [0, 0.5];
	}

	override function update(elapsed:Float) {
		if (camera == null) return;

		shader.iTime -= elapsed * snowSpeed;
		shader.cameraOffset = [camera.scroll.x + camera.width * 0.5, camera.scroll.y + camera.height * 0.5];
		shader.cameraZoom = camera.zoom * 2;
	}

	public function applyShader(?obj:Dynamic) {
		if (FlxG.save.data.starry_snow_quality < 0.1) return;

		obj ??= camera;

		if (obj is FlxSprite) {
			obj.shader = shader;
			return;
		}
		obj.addShader(shader);
	}
}