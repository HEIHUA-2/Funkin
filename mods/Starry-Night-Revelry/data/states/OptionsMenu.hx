var warp;

var bitmap = FlxG.bitmap.add(Paths.image('shaders/lightwarp'));

function postCreate() {
	warp = new CustomShader('warp');
	warp.warpDistance = 0.2;
	warp.bitmap_warp = bitmap;
	warp.warpSize = 1;
	warp.data.bitmap_warp.wrap = 2;
	warp.data.bitmap_warp.filter = 4;

	bg.loadGraphic(Paths.image('stages/snow/light'));
	bg.scale.set(20, 20);
	bg.updateHitbox();
	bg.antialiasing = false;
	bg.shader = warp;

	updateMenu();
}

var timer = new FlxTimer();
function update(elapsed:Float) {
	warp.iTime = FlxG.game.ticks * 0.00001;

	if (controls.ACCEPT)
		timer.start(0.05, updateMenu);

	if (controls.BACK)
		updateMenu();
}

function updateMenu() {
	var menu = tree[tree.length - 1];

	switch (menu.name) {
		case 'Options Menu':
			for (sprite in menu)
				if (sprite.text == 'Starry Options')
					sprite.__text.color = 0xFFCEF4FF;
		case 'Starry Options':
			for (sprite in menu) {
				if (sprite.text == 'UI Options')
					sprite.__text.color = 0xFFCEF4FF;
				if (sprite.text == 'Game Difficulty')
					sprite.__text.color = 0xFFCEF4FF;
				if (sprite.text == 'Shader Quality')
					sprite.__text.color = 0xFFCEF4FF;
				if (sprite.text == 'Debug Options')
					sprite.__text.color = 0xFFCEF4FF;
			}
			#if mobile
			removeTouchPad();
			addTouchPad('UP_DOWN', 'A_B');
			#end
		case 'UI Options':
			for (sprite in menu) {
				if (sprite.text == 'Middle Scroll')
					sprite.__text.color = 0xFFCEF4FF;
			}
		case 'Game Difficulty':
			for (sprite in menu) {
				if (sprite.text == 'Mod Chart')
					sprite.__text.color = 0xFFCEF4FF;
				if (sprite.text == 'Hurt Note')
					sprite.__text.color = 0xFFCEF4FF;
			}
		case 'Shader Quality':
			for (sprite in menu) {
				if (sprite.text == 'Snow Quality')
					sprite.color = 0xFFCEF4FF;
				if (sprite.text == 'Blur Max Quality')
					sprite.color = 0xFFCEF4FF;
				if (sprite.text == 'VCR Shader')
					sprite.color = 0xFFCEF4FF;
				if (sprite.text == 'VCR Note Shader')
					sprite.color = 0xFFCEF4FF;
				if (sprite.text == 'Mirror Wrap Transform')
					sprite.__text.color = 0xFFCEF4FF;
			}
			#if mobile
			removeTouchPad();
			addTouchPad('LEFT_FULL', 'A_B');
			#end
		case 'Debug Options':
			for (sprite in menu)
				if (sprite.text == 'Debug Mode')
					sprite.__text.color = 0xFFCEF4FF;
	}
}

function destroy() {
	FlxG.bitmap.remove(bitmap);
}