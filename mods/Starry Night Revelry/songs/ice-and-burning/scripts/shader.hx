static var bfShadow:FunkinSprite;
static var vcrshader:CustomShader;
static var MirrorRepeatEffect:CustomShader;

function create() {
	vcrshader = new CustomShader('light_efficiency_rgb_vcr');
	vcrshader.amount = 0;
	vcrshader.brightness = 1.7;
	vcrshader.liang = 1;
	if (FlxG.save.data.starry_vcrshader) FlxG.game.addShader(vcrshader);

	MirrorRepeatEffect = new CustomShader('mirror_repeat_effect');
	MirrorRepeatEffect.x = 0;
	MirrorRepeatEffect.y = 0;
	MirrorRepeatEffect.zoom = 1;
	MirrorRepeatEffect.angle = 0;
	if (FlxG.save.data.starry_MirrorRepeatEffect) FlxG.camera.addShader(MirrorRepeatEffect);
}

function postUpdate(elapsed:Float)
	vcrshader.iTime = gameTime;
// 已经是优化大师了