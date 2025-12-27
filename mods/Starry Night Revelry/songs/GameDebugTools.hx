import flixel.text.FlxText;
import flixel.util.FlxColor;

static var camPrint:HudCamera;

FlxG.cameras.add(camPrint = new HudCamera(), false);
camPrint.bgColor = 0x00;

public var HxDebugGroup:Array<FunkinText> = [];

public function p(text:String) {
	addTextToDebug('' + text);
}


public function debugPrint(text:String, text1:String, text2:String, text3:String, text4:String) {
	if (text == null) text = '';
	if (text1 == null) text1 = '';
	if (text2 == null) text2 = '';
	if (text3 == null) text3 = '';
	if (text4 == null) text4 = '';
	addTextToDebug('' + text + text1 + text2 + text3 + text4);
}


public function addTextToDebug(text:String, color:FlxColor=FlxColor.WHITE) {
	if (text != null || text != '') {
		if (HxDebugGroup != null)
			for (i => spr in HxDebugGroup) {
				spr.y += 20;
				if (spr.y > 720) {
					spr.destroy();
					HxDebugGroup.remove(spr);
				}
			}

		var textToDebug = new FunkinText(0, 0, 0, text, 20);
		textToDebug.cameras = [camPrint];
		textToDebug.borderSize = 1.25;
		FlxTween.tween(textToDebug, {alpha: 1}, 5, {ease: FlxEase.linear,
		onComplete: function(tween:FlxTween) {
			FlxTween.tween(textToDebug, {alpha: 0}, 1);
		}});
		HxDebugGroup.push(add(textToDebug));
	} else {
	if (text == '') addTextToDebug('""');

	if (text == null) addTextToDebug('null');
	}
}


function update(elapsed:Float) {
	if (FlxG.keys.justPressed.TAB)
		if (player.cpu)
			player.cpu = false;
		else
			player.cpu = true;
	if (FlxG.keys.justPressed.ONE
		)
		skipSongPosition((Conductor.songPosition + 10000) / 1000);
}


public function skipSongPosition(time:Float) {
	Conductor.songPosition = FlxG.sound.music.time = vocals.time = time * 1000;
	if (!player.cpu) {
		player.cpu = true;
		FlxTween.num(0, 1, 1.5, {}, (val:Float) -> {
			if (val == 1)
				player.cpu = false;
		});
	}
}
// 一堆调试用的东西，按照常理来说他应该不会出现在模组发布，如果你看到他那个代表我忘记删了