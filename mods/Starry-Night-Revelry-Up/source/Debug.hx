import openfl.text.TextField;
import openfl.text.TextFormat;

class Debug {
	var HxDebugGroup:Array<TextField> = [];

	public function addTextToDebug(text:String, ?color:FlxColor) {
		color ??= FlxColor.WHITE;

		if (text != null || text != '') {
			if (HxDebugGroup != null)
				for (i => spr in HxDebugGroup) {
					spr.y += 20;
					if (spr.y > 720) {
						FlxG.game.removeChild(spr);
						HxDebugGroup.remove(spr);
					}
				}

			var textToDebug = new TextField(0, 0, 0, text, 20);
			textToDebug.x = 0;
			textToDebug.y = 0;
			textToDebug.text = text;
			textToDebug.textColor = 0xaaaaaa;
			textToDebug.multiline = textToDebug.wordWrap = false;
			FlxTween.tween(textToDebug, {alpha: 1}, 5, {onComplete: function(tween:FlxTween) {
				FlxTween.tween(textToDebug, {alpha: 0}, 1);
			}});
			HxDebugGroup.push(textToDebug);
			FlxG.game.addChild(textToDebug);
		} else {
		if (text == '') addTextToDebug('""');

		if (text == null) addTextToDebug('null');
		}
	}
}