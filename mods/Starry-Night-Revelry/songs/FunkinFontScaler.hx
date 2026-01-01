var textGroup:Array<FunkinText> = [];
var textSizeGroup:Array<FunkinText> = [];
var textSize:Float;
var textSizeOld:Float;
var windowsSize:Float;


public function updateTextSize(text:FunkinText, ?size:Float, ?insert:Bool) {
	if (size == null) size = 1;
	var sizes:Float = textSize * size;
	text.borderSize /= sizes;
	text.size /= sizes;
	text.fieldWidth /= sizes;
	text.scale.x *= sizes;
	text.scale.y *= sizes;
	text.updateHitbox();
	if (insert) textGroup.insert(0, text);
}


function updateTextSize2(text:FunkinText, size:Float) {
	var sizes:Float = size;
	text.borderSize /= sizes;
	text.size /= sizes;
	text.fieldWidth /= sizes;
	text.scale.x *= sizes;
	text.scale.y *= sizes;
	text.updateHitbox();
}


var gameSize = 1280 / 720;
function create() {
	windowsSize = window.width / window.height;
	if (windowsSize > gameSize) {
		textSize = 1 / (window.width / 1280);
	} else {
		textSize = 1 / (window.height / 720);
	}
	textSizeOld = textSize;
}

function gameResized(w:Int, h:Int) {
	windowsSize = w / h;

	if (windowsSize < gameSize) {
		textSize = 1 / (w / 1280);
	} else {
		textSize = 1 / (h / 720);
	}
	if (textSize != textSizeOld) {
		for (text in textGroup) {
			updateTextSize2(text, textSize / textSizeOld, false);
		}
		textSizeOld = textSize;
	}
}

FlxG.signals.gameResized.add(gameResized);

function destroy()
	FlxG.signals.gameResized.remove(gameResized);
// 闲着没事写的，根据乱七八糟的计算得出字体在画面上的正确分辨率