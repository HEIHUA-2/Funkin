import openfl.display.BlendMode;

static var lightEfficiency:CustomShader;

static var bfShadow:FunkinSprite = new FunkinSprite();
static var dadShadow:FunkinSprite = new FunkinSprite();
static var bfShadowAlpha = 0.3;
static var dadShadowAlpha = 0.3;
static var shadow_optimization:CustomShader;
static var shadow_optimization1:CustomShader;

static var comboGroupColor = 0xffe1e1e1;

function create() {
	comboGroupColor = 0xffe1e1e1;
	bfShadowAlpha = 0.3;
	dadShadowAlpha = 0.3;
}


function postCreate() {
	var bloom = new CustomShader('bloom');
	// bloom.sigma = 20;

	bloom.A = 0.5;
	bloom.DIM = 2;
	bloom.QUALITYS = 0.15;
	bloom.SIZE = 20;
	if (FlxG.save.data.starry_bloom) camGame.addShader(bloom);

	bfShadow = FunkinSprite.copyFrom(boyfriend);
	bfShadow.flipY = !boyfriend.flipY;
	bfShadow.color = 0x000000;
	insert(members.indexOf(dad), bfShadow);
	add(bfShadow);
	bfShadow.skew.x = 25;

	shadow_optimization = new CustomShader('shadow_optimization');
	shadow_optimization.offsetY = -45;
	shadow_optimization.QUALITY = 8;
	if (FlxG.save.data.starry_texture_shader) bfShadow.shader = shadow_optimization;


	dadShadow = FunkinSprite.copyFrom(dad);
	dadShadow.flipY = !dad.flipY;
	dadShadow.color = 0x000000;
	insert(members.indexOf(dad), dadShadow);
	add(dadShadow);
	dadShadow.skew.x = 24.999649274823648905059958939010979007; //因为站位不同，所以他们的影子应该会有不同的倾斜角度

	shadow_optimization1 = new CustomShader('shadow_optimization');
	shadow_optimization1.offsetY = -25;
	shadow_optimization1.QUALITY = 8;
	if (FlxG.save.data.starry_texture_shader) dadShadow.shader = shadow_optimization1;



	maxCamZoom = 2;

	stage.stageSprites['sky'].scale.set(30.926829268292*2,30.35*2);
	stage.stageSprites['Light'].scale.set(30.926829268292*2,30.35*2);
	stage.stageSprites['Light_2'].scale.set(19.444444444444*2,19.444444444444*2);

	stage.stageSprites['Light'].updateHitbox();
	stage.stageSprites['Light_2'].updateHitbox();
	stage.stageSprites['Sunlight'].updateHitbox();
	stage.stageSprites['sky'].updateHitbox();

	stage.stageSprites['Lake_Surface'].color = 0xffc8c8c8;
	stage.stageSprites['Mountain'].color = 0xffc8c8c8;
	stage.stageSprites['Snow'].color = 0xffc8c8c8;
	boyfriend.color = 0xffc8c8c8;
	dad.color = 0xffc8c8c8;

	stage.stageSprites['Light_2'].blend = BlendMode.ADD;


	lightEfficiency = new CustomShader('light_efficiency_rgb');
	lightEfficiency.brightness = 1.7;
	if (FlxG.save.data.starry_lightEfficiency && (PlayState.instance.SONG.meta.name != 'blizzard-eve' && PlayState.instance.SONG.meta.name != 'ice-and-burning')) FlxG.game.addShader(lightEfficiency);
}


function postUpdate() {
	if (comboGroup.length != 0) for (spr in comboGroup) spr.color = comboGroupColor;



	dadShadow.alpha = dad.alpha * dadShadowAlpha;
	dadShadow.setPosition(dad.x - 45, dad.y - 70);
	dadShadow.frameOffset.set(dad.frameOffset.x, dad.frameHeight - dad.frameOffset.y - 825);
	dadShadow.offset = dad.offset;
	dadShadow.animation.frameName = dad.animation.frameName;

	bfShadow.alpha = boyfriend.alpha * bfShadowAlpha;
	bfShadow.setPosition(boyfriend.x - 75, boyfriend.y);
	bfShadow.frameOffset.set(boyfriend.frameOffset.x, boyfriend.frameHeight - boyfriend.frameOffset.y - 780);
	bfShadow.offset = boyfriend.offset;
	bfShadow.animation.frameName = boyfriend.animation.frameName;
}


function destroy() FlxG.game.setFilters([]);