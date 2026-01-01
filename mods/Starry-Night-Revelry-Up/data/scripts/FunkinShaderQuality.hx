public function shaderQualityString(path:String) {
	if (path == 'vcr')
		if (FlxG.save.data.starry_VCR != 'disable') {
			return FlxG.save.data.starry_VCR + '/' + path;
		}
	if (path == 'vcr_note')
		if (FlxG.save.data.starry_VCR_Note != 'disable') {
			return FlxG.save.data.starry_VCR_Note + '/' + path;
		}
	return;
}

public function shaderQuality(path:String, camera) {
	var shaderPath:String = shaderQualityString(path);
	var shader:CustomShader;

	if (shaderPath != null) {
		shader = new CustomShader(shaderPath);

		for (cam in camera) cam.addShader(shader);

		return shader;
	}

	return new CustomShader('high/' + path);
}