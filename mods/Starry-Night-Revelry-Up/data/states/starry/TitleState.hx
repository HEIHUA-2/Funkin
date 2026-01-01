import haxe.Timer;
import funkin.backend.MusicBeatState;
import funkin.backend.scripting.Script;
import funkin.menus.TitleState;
import shaders.BlurFilter;

FlxG.camera.zoom = 0.8;
FlxG.camera.bgColor = 0xFFFFFFFB;

CoolUtil.playMenuSong();

var cutscene = 'cutscene';
var tweens:Array<FlxTween> = [];
var delayTimer:Int;

var mainMenuInauguralState;

var bitmap = FlxG.bitmap.add(Paths.image('shaders/lightwarp'));

var background:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/titlescreen_inaugural/background'));
background.scale.set(0.6, 0.6);
background.updateHitbox();
background.antialiasing = true;
add(background);

var starry_logo:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/titlescreen_inaugural/starry_logo'));
starry_logo.scrollFactor.set(0.8, 0.8);
starry_logo.zoomFactor = 0.8;
starry_logo.scale.set(0.6, 0.6);
starry_logo.updateHitbox();
starry_logo.antialiasing = true;
starry_logo.alpha = 0.001;
add(starry_logo);

var stella_reflection:FunkinSprite = new FunkinSprite(0, 450, Paths.image('menus/titlescreen_inaugural/stella'));
stella_reflection.scale.set(0.6, 0.6);
stella_reflection.updateHitbox();
stella_reflection.flipY = true;
stella_reflection.antialiasing = true;
stella_reflection.shader = new CustomShader('menu/water_reflection');
stella_reflection.shader.iTime = 0;
stella_reflection.shader.bitmap_reflection = bitmap;
stella_reflection.shader.data.bitmap_reflection.wrap = 2;
stella_reflection.shader.data.bitmap_reflection.filter = 4;
add(stella_reflection);

var stella:FunkinSprite = new FunkinSprite(0, 0, Paths.image('menus/titlescreen_inaugural/stella'));
stella.scale.set(0.6, 0.6);
stella.updateHitbox();
stella.antialiasing = true;
add(stella);

tweens.push(FlxTween.num(2, 0.1, 10, {}, (val:Float) -> {
	FlxG.sound.music.volume = val;
}));

var blur:BlurFilter = new BlurFilter(200);
blur.apply(FlxG.camera);
delayTimer = Timer.delay(() -> {
	tweens.push(FlxTween.num(200, 0, 10, {ease: FlxEase.expoOut}, (val:Float) -> {
		blur.set(val);
	}));
	tweens.push(FlxTween.num(0.8, 1, 10, {
		ease: FlxEase.quartOut,
		onComplete: () -> {
			cutscene = false;
			tweens.push(FlxTween.num(0, 1, 4, {onComplete: () -> {
					cutscene = 'menu';
				}
			}, (val:Float) -> {
				starry_logo.alpha = val;
			}));
		}
	}, (val:Float) -> {
		FlxG.camera.zoom = val;
	}));
}, 2500);

function postUpdate(elapsed:Float) {
	if (stella_reflection.shader != null) stella_reflection.shader.iTime += elapsed;

	if (stella_reflection.shader != null) starry_logo.y = Math.sin(stella_reflection.shader.iTime * 0.5) * 10 + 10;

	if (cutscene == 'menu' && (FlxG.mouse.justPressed || controls.ACCEPT)) {
		cutscene = 'cutscene_menu';
		for (i in 0...tweens.length) {
			if (tweens[i] != null) {
				tweens[i].destroy();
			}
		}

		FlxTween.num(FlxG.camera.zoom, 1.2, 2, {ease: FlxEase.quartOut}, (val:Float) -> {
			FlxG.camera.zoom = val;
		});
		FlxTween.num(FlxG.camera.scroll.y, -1000, 2, {ease: FlxEase.quartIn}, (val:Float) -> {
			FlxG.camera.scroll.y = val;
		});
		FlxTween.num(FlxG.sound.music.volume, 2, 1, {
			onComplete: () -> {
				if (FlxG.save.data.starry)
					FlxTween.num(FlxG.sound.music.volume, 0, 0.9, {}, (val:Float) -> {
						FlxG.sound.music.volume = val;
					});
			}
		}, (val:Float) -> {
			FlxG.sound.music.volume = val;
		});
		Timer.delay(() -> {
			if (!FlxG.save.data.starry) {
				mainMenuInauguralState = importScript('data/states/starry/MainMenuInauguralState');
				mainMenuInauguralState.call('create');
				FlxTween.num(300, 0, 6, {ease: FlxEase.quartOut}, (val:Float) -> {
					blur.set(val);
				});
				FlxTween.num(-2000, 0, 5, {ease: FlxEase.quartOut}, (val:Float) -> {
					FlxG.camera.scroll.y = val;
				});
				FlxTween.num(FlxG.sound.music.volume, 0.25, 2, {}, (val:Float) -> {
					FlxG.sound.music.volume = val;
				});
				background.destroy();
				starry_logo.destroy();
				stella_reflection.destroy();
				stella.destroy();
			} else {
				background.destroy();
				starry_logo.destroy();
				stella_reflection.destroy();
				stella.destroy();

				Flags.MOD_REDIRECT_STATES.set('MainMenuState', 'starry/MainMenuState');
				Flags.MOD_REDIRECT_STATES.set('StoryMenuState', 'starry/MainMenuState');
				Flags.DEFAULT_MENU_MUSIC = 'freakyMenu';

				FlxG.sound.music.destroy();

				mainMenuInauguralState = importScript('data/states/starry/MainMenuState');
				mainMenuInauguralState.call('create');
				mainMenuInauguralState.call('transIn');
				FlxTween.num(300, 0, 6, {ease: FlxEase.quartOut}, (val:Float) -> {
					blur.set(val);
				});
				FlxTween.num(-2000, 0, 5, {ease: FlxEase.quartOut}, (val:Float) -> {
					FlxG.camera.scroll.y = val;
				});
			}
		}, 2000);
	}

	if (cutscene == 'cutscene' && (FlxG.mouse.justPressed || controls.ACCEPT)) {
		cutscene = 'menu';

		if (delayTimer != null) {
			delayTimer.stop();
			delayTimer = null;
		}

		for (i in 0...tweens.length) {
			if (tweens[i] != null) {
				tweens[i].destroy();
			}
		}

		blur.set(0);
		FlxG.camera.zoom = 1;
		starry_logo.alpha = 1;
		tweens.push(FlxTween.num(FlxG.sound.music.volume, 0.1, 2, {}, (val:Float) -> {
			FlxG.sound.music.volume = val;
		}));
	}
}

function destroy() {
	FlxG.camera.bgColor = 0xFF000000;
	FlxG.bitmap.remove(bitmap);
}