import utils.StringUtil;

class BlurShader extends FlxBasic {
	public var shader:CustomShader;

	public var blur_size(get, set):Array<Float>;
	var _blur_size:Array<Float> = [0.0, 0.0];

	function get_blur_size():Array<Float> {return _blur_size;}

	function set_blur_size(val:Array<Float>):Array<Float> {
		_blur_size = val;
		shader.blur_size = val;
		return _blur_size;
	}

	var StringUtil:StringUtil = new StringUtil();

	public function new() {
		super();
		shader = new CustomShader('blur');
		shader.fragmentPrefix = '
			#define BLUR_QUALITY ' + StringUtil.toGLSLFloat(FlxG.save.data.starry_blur_max_quality) + '
		';
		shader.blur_size = [0.0, 0.0];
	}

	public function applyShader(obj:Dynamic) {
		if (FlxG.save.data.starry_blur_max_quality == 0) return;

		if (obj is FlxSprite) {
			obj.shader = shader;
			return;
		}
		obj.addShader(shader);
	}
}