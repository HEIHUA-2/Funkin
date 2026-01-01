import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxAxes;
import funkin.options.type.PortraitOption;
import funkin.options.type.GithubIconOption;
import funkin.backend.system.framerate.Framerate;

var frameCamera = new HudCamera();
frameCamera.bgColor = 0x00;
FlxG.cameras.add(frameCamera, false);

var fog:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/freeplaymenu/fog'));
fog.scrollFactor.set();
fog.color = 0xFF000000;

var starbg:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/creditsmenu/starbg'));
starbg.scrollFactor.set();

var star1:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/creditsmenu/star1'));
star1.scrollFactor.set();

var star2:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/creditsmenu/star2'));
star2.scrollFactor.set();

var star3:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/creditsmenu/star3'));
star3.scrollFactor.set();

var light:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/creditsmenu/light'));
light.scrollFactor.set();
light.blend = 0;

var printing:FunkinSprite = new FunkinSprite(1000, 400, Paths.image('menus/creditsmenu/printing'));
printing.scrollFactor.set();

var snowflake_pattern:FunkinSprite = new FunkinSprite(-100, -200, Paths.image('menus/creditsmenu/snowflake_pattern'));
snowflake_pattern.scrollFactor.set();

var chain1:FlxBackdrop = new FlxBackdrop(Paths.image('menus/creditsmenu/chain'), FlxAxes.X, 1);
chain1.setPosition(0, 0);
chain1.rotation = 12.5;
chain1.scrollFactor.set();

var chain2:FlxBackdrop = new FlxBackdrop(Paths.image('menus/creditsmenu/chain'), FlxAxes.X, 1);
chain2.setPosition(400, 700);
chain2.offset.set(0, 0);
chain2.rotation = 70;
chain2.scrollFactor.set();

var border_1 = new FunkinSprite(0, 0).makeGraphic(1280, 1, 0xff000000);
border_1.scrollFactor.set();
var border_2 = new FunkinSprite(0, 0).makeGraphic(1, 720, 0xff000000);
border_2.scrollFactor.set();
var border_3 = new FunkinSprite(0, 720 - 1).makeGraphic(1280, 1, 0xff000000);
border_3.scrollFactor.set();
var border_4 = new FunkinSprite(1280 - 1, 0).makeGraphic(1, 720, 0xff000000);
border_4.scrollFactor.set();

var frame:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/creditsmenu/frame'));
frame.scrollFactor.set();
frame.cameras = [frameCamera];

var textbox:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/creditsmenu/textbox'));
textbox.scrollFactor.set();
function postCreate() {
  bg.destroy();

	FlxG.camera.bgColor = 0xFF40344B;

	add(fog);
	add(starbg);
	add(star1);
	add(star2);
	add(star3);
	add(textbox);
	add(light);
	add(chain1);
	add(chain2);
	add(printing);
	add(snowflake_pattern);
	add(border_1);
	add(border_2);
	add(border_3);
	add(border_4);
	add(frame);

	titleLabel.alignment = 'center';
	descLabel.alignment = 'center';

	titleLabel.y += 5;
}

var frameNumber:Int = 0;
var fogNumber:Int = 0;
var animationTimer = new FlxTimer().start(1, (timer:FlxTimer) -> {
	starbg.offset.set(FlxG.random.float(-20, 20), FlxG.random.float(-20, 20));

	star1.offset.set(FlxG.random.float(-20, 20), FlxG.random.float(-20, 20));
	star2.offset.set(FlxG.random.float(-20, 20), FlxG.random.float(-20, 20));
	star3.offset.set(FlxG.random.float(-20, 20), FlxG.random.float(-20, 20));

	fog.flipX = FlxG.random.bool();
	fog.flipY = FlxG.random.bool();

	frameNumber += 1;
	frame.animation.frameName = 'frame' + (frameNumber % 3);

	fogNumber += 1;
	fog.animation.frameName = 'fog000' + (fogNumber % 5) + '.png';
}, 0);

var animationTimer2 = new FlxTimer().start(1 / 24, (timer:FlxTimer) -> {
	frame.flipX = FlxG.random.bool();
	frame.flipY = FlxG.random.bool();
	frame.offset.set(FlxG.random.float(-1, 1), FlxG.random.float(-1, 1));
	printing.angle += 0.5;
	snowflake_pattern.angle -= 0.2;
	chain1.x -= 0.5;
	chain2.x -= 0.25;
}, 0);
function postUpdate(elapsed:Float) {
	for (menu in tree) {
		if (menu == null) continue;

		for (i in 0...menu.length) {
			var object = menu.members[i];
			if (object == null) continue;

			if (object is PortraitOption) {
				object.x = (FlxG.width - object.width) * 0.5 + menu.x + 37.5 + Math.sin((object.y + object.height * 0.5) * 0.05) * 10;
			}

			if (object is GithubIconOption) {
				object.x = (FlxG.width - object.width) * 0.5 + menu.x + 37.5 + Math.sin((object.y + object.height * 0.5) * 0.05) * 10;
			}
		}
	}
	Framerate.offset.y = 0;
}

function destroy() {
	FlxG.camera.bgColor = 0xFF000000;

	animationTimer.cancel();
	animationTimer2.cancel();
}