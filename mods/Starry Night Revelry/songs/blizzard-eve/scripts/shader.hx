static var bfShadow:FunkinSprite;
static var vcrshader:CustomShader;

function create() {
	vcrshader = new CustomShader('light_efficiency_rgb_vcr');
	vcrshader.amount = 0;
	vcrshader.brightness = 1.7;
	vcrshader.liang = 1;
	if (FlxG.save.data.starry_vcrshader) FlxG.game.addShader(vcrshader);
}

function postUpdate(elapsed:Float)
	vcrshader.iTime = gameTime;
// 真的是优化极限了