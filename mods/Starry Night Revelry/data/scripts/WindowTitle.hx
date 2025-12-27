import funkin.backend.utils.WindowUtils;
import funkin.backend.system.framerate.CodenameBuildField;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.assets.Paths;


public function setTitle(text:String) {
	#if !android
		window.title = text;
	#else
		Framerate.codenameBuildField.text = text;
	#end
}