import funkin.backend.system.framerate.CodenameBuildField;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.assets.Paths;
import lime.graphics.Image;
import funkin.backend.system.framerate.Framerate;
import cpp.Sys;

static var starryVersion = ' v0.1.4 ';

// 为了让这些变量持续运行
var oldTime = Sys.time();
static var gameTime = 0;
static var elapsedTime = 0;

var framerates = [];

static var w:Float = FlxG.width / 2;
static var h:Float = FlxG.height / 2;

static var sectionCrochet;

static var stepElapsed;
static var beatElapsed;
static var sectionElapsed;

function new() {
	// game
	FlxG.save.data.starry_middle_scroll ??= false;

	// difficulty
	FlxG.save.data.starry_hurt_note ??= true;

	// shaders
	FlxG.save.data.starry_bloom ??= #if android false #else true #end;
	FlxG.save.data.starry_vcrshader ??= true;
	FlxG.save.data.note_starry_vcrshader ??= true;
	FlxG.save.data.starry_texture_shader ??= true;
	FlxG.save.data.starry_lightEfficiency ??= true;
	FlxG.save.data.starry_MirrorRepeatEffect ??= true;

	// Background
	FlxG.save.data.starry_high_quality_particle_amount ??= #if android 0.75 #else 1 #end;
	FlxG.save.data.starry_high_quality_particle ??= false;

	// events
	FlxG.save.data.starry_modchart ??= true;
	FlxG.save.data.starry_modchart_refresh_rate ??= #if android 30 #else 60 #end;


  window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('iconOG'))));
}


function update(elapsed:Float) {
	if (FlxG.keys.justPressed.F5) FlxG.resetState();

	elapsedTime = Sys.time() - oldTime;
	gameTime += elapsedTime;
	oldTime = Sys.time();

	sectionCrochet = 240 / Conductor.bpm;
}


function preStateSwitch() {
	window.title = 'Starry Night Revelry Demo' + starryVersion;
}
// 一堆新变量真不错