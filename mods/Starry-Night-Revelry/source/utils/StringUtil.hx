class StringUtil {
	public function toGLSLFloat(value:Dynamic):String {
		var str:String = Std.string(value);

		if (str.indexOf('.') == -1) {
			return str + '.0';
		}

		return str;
	}
}