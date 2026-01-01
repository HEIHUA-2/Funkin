import flixel.util.FlxColor;
import haxe.Timer;

var debugMode = true;

static var player_cpu:Bool = FlxG.save.data.starry_debug;
static var player_cpu_keys:Bool = player_cpu;

var s;
function create() {
	s = !PlayState.opponentMode ? player : cpu;
}


function update() {
	if (!debugMode) return;

	if (FlxG.keys.justPressed.TAB #if mobile || checkPositionInCameraView() #end) {
		player_cpu = !player_cpu;
		player_cpu_keys = !player_cpu_keys;
	}
	if (player_cpu_keys) player_cpu = true;
	if (FlxG.keys.pressed.ONE) skipSongPosition(2);
	if (FlxG.keys.pressed.TWO) skipSongPosition(10);
	if (FlxG.keys.pressed.THREE) skipSongPosition(50);
	s.cpu = player_cpu;
}


function onNoteHit(e) {
	if (!debugMode && !player_cpu_keys) return;

	if (e.characters != s.characters) return;

	e.healthGain = 0.023;
	e.player = true;
	e.countAsCombo = e.countScore = e.showSplash = !e.note.isSustainNote;
}


var cpuTimer:Timer;
var _tweensTimer;
public function skipSongPosition(time:Float) {
	if (!debugMode) return;

	FlxG.timeScale = time;
	if (_tweensTimer != null)
		_tweensTimer.stop();
	_tweensTimer = new Timer(50);
	_tweensTimer.run = () -> {
		FlxG.timeScale = 1;
		_tweensTimer.stop();
		_tweensTimer = null;
	}

	player_cpu = true;

	if (cpuTimer != null) {
		cpuTimer.stop();
		cpuTimer = null;
	}

	cpuTimer = new Timer(1000);
	cpuTimer.run = () -> {
		player_cpu = false;
		cpuTimer.stop();
		cpuTimer = null;
	};
}


#if mobile
function checkPositionInCameraView()
{
	if (!FlxG.mouse.justPressed) return false;

	var pos = FlxG.mouse.getPositionInCameraView(camHUD);

	if (pos.x < 0 || pos.x > FlxG.width) return true;
	if (pos.y < 0 || pos.y > FlxG.height) return true;

	return false;
}
#end
// 一堆调试用的东西，你可以在设置当中自由开关调试，默认为关闭