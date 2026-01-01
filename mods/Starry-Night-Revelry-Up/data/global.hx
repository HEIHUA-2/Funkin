import funkin.backend.utils.MemoryUtil;
import FunkinStepEvent;
import Debug;

FlxG.game.stage.quality = 0;

static var event:FunkinStepEvent;

static var debug:Debug = new Debug();

var memory = MemoryUtil.currentMemUsage();
function preStateCreate() {
	if (event != null) event.destroy();
	event = new FunkinStepEvent();

	MemoryUtil.clearMajor();
}

function preStateSwitch() {
	FlxG.game.setFilters([]);
}

function new() {
	FlxG.save.data.starry ??= false;
	// game
	FlxG.save.data.starry_middle_scroll ??= false;

	// difficulty
	FlxG.save.data.starry_hurt_note ??= true;

	// shaders
	FlxG.save.data.starry_snow_quality ??= 2;
	FlxG.save.data.starry_blur_max_quality ??= 10;
	FlxG.save.data.starry_VCR ??= 'high';
	FlxG.save.data.starry_VCR_Note ??= 'high';
	FlxG.save.data.starry_mirror_wrap_transform ??= true;

	// events
	FlxG.save.data.starry_modchart ??= true;

	// debugs
	FlxG.save.data.starry_debug ??= false;

	Flags.MOD_REDIRECT_STATES.set('TitleState', 'starry/TitleState');
	Flags.MOD_REDIRECT_STATES.set('MainMenuState', 'starry/MainMenuInauguralState');
	Flags.MOD_REDIRECT_STATES.set('StoryMenuState', 'starry/MainMenuInauguralState');
	Flags.DEFAULT_MENU_MUSIC = 'snow';
}

function onScriptCreated(script) {
	switch (script.path) {
		case StringTools.endsWith(script.path, 'states/FreeplayState.hx'):
			script.parser.allowJSON = false;
			script.parser.allowMetadata = false;
			script.interp.staticVariables = false;
			script.interp.allowStaticVariables = script.interp.allowPublicVariables = false;
		case StringTools.endsWith(script.path, 'ModChartManager.hx'):
			script.parser.allowJSON = false;
			script.parser.allowMetadata = false;
	}
	if (StringTools.startsWith(script.path, 'songs/')) {
		script.parser.allowJSON = false;
		script.parser.allowMetadata = false;
	}
}

function destroy() {
	event.destroy();
	event = null;
	debug = null;
}
// 一堆新变量真不错