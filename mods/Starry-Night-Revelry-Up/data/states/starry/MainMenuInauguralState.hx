import openfl.ui.Mouse;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import Type;
import flixel.text.FlxTextBorderStyle;

FlxG.camera.bgColor = 0xFFFFFFFB;

var bg2:FunkinSprite = new FunkinSprite(-20, -20, Paths.image('menus/mainmenu/bg2'));
var bg3:FunkinSprite = new FunkinSprite(-20, -20 + 62, Paths.image('menus/mainmenu/bg3'));
var storyMode:FunkinSprite = new FunkinSprite(650, 345, Paths.image('menus/mainmenu/starry_storymode'));
var freeplay:FunkinSprite = new FunkinSprite(575, 465, Paths.image('menus/mainmenu/starry_freeplay'));
var options:FunkinSprite = new FunkinSprite(575, 575, Paths.image('menus/mainmenu/starry_options'));
var credit:FunkinSprite;
var versionShit:FunkinText = new FunkinText(5 + 2, 0, 0, 'Codename Engine - v' + Application.current.meta.get('version') + '\n' + window.title, 16 * 2);

var choose;
var choose_old;

var defaultCamZoom = 1;

var switchState = false;

var state;

var camOffset = [0, 0];

var versionCam = new HudCamera();
versionCam.bgColor = 0x00;
FlxG.cameras.add(versionCam, false);

var bitmap = FlxG.bitmap.add(Paths.image('shaders/lightwarp'));

function create() {
	bg2.antialiasing = bg3.antialiasing = true;
	bg2.scrollFactor.set(0.7, 0.7);

	storyMode.addAnim('normal', 'normal');
	storyMode.addAnim('hit', 'hit');
	storyMode.antialiasing = true;

	freeplay.addAnim('normal', 'normal');
	freeplay.addAnim('hit', 'hit');
	freeplay.antialiasing = true;
	freeplay.colorTransform.redMultiplier = 0.3;
	freeplay.colorTransform.greenMultiplier = 0.3;
	freeplay.colorTransform.blueMultiplier = 0.3;
	freeplay.colorTransform.redOffset = 255 * 0.6;
	freeplay.colorTransform.greenOffset = 255 * 0.6;
	freeplay.colorTransform.blueOffset = 255 * 0.6;

	options.addAnim('normal', 'normal');
	options.addAnim('hit', 'hit');
	options.antialiasing = true;

	credit = new FunkinSprite(150, 350).makeGraphic(400, 300, 0xffffffff);
	credit.alpha = 0.001;

	add(bg2);
	add(bg3);
	add(options);
	add(freeplay);
	add(storyMode);
	add(credit);

	versionShit.y = FlxG.height - versionShit.height * 0.5 - 2;
	versionShit.scrollFactor.set();
	versionShit.cameras = [versionCam];
	versionShit.borderSize = 2;
	versionShit.antialiasing = true;
	versionShit.scale.set(0.5, 0.5);
	versionShit.updateHitbox();
	add(versionShit);

	bg2.zoomFactor = 0.7;
}

function postUpdate(elapsed) {
	if (FlxG.keys.justPressed.SEVEN)
	{
		persistentUpdate = false;
		persistentDraw = true;
		Mouse.cursor = 'auto';
		openSubState(new EditorPicker());
	}


	FlxG.camera.zoom = lerp(FlxG.camera.zoom, defaultCamZoom, 0.05);

	FlxG.camera.scroll.x = lerp(FlxG.camera.scroll.x, (Math.min(1280, Math.max(0, FlxG.mouse.x)) - 640) * 0.03125 + camOffset[0], 0.05);	
	FlxG.camera.scroll.y = lerp(FlxG.camera.scroll.y, (Math.min(720, Math.max(0, FlxG.mouse.y)) - 360) * 0.03125 + camOffset[1], 0.05);

	FlxG.mouse.visible = true;
	FlxG.mouse.useSystemCursor = true;
	Mouse.cursor = 'auto';

	var hoveredButton:FlxSprite = null;

	function checkButtonHover(button:FlxSprite):Bool {
		return FlxG.mouse.overlaps(button);
	}

	function handleButton(button:FlxSprite, stateClass:Class<FlxState>, buttonId:String) {
		if (!switchState) {
			if (checkButtonHover(button)) {
				if (hoveredButton == null) {
					hoveredButton = button;
				}

				if (hoveredButton == button) {
					Mouse.cursor = 'button';
					button.playAnim('hit', true);
					
					if (choose != buttonId) {
						choose = buttonId;
						FlxG.sound.play(Paths.sound('menu/scroll'));
					}
					
					if (FlxG.mouse.justPressed) {
						var enterSound:FlxSound = new FlxSound().loadEmbedded(Paths.sound("menu/confirm")).play();

						Mouse.cursor = 'auto';

						switchState = true;
						state = stateClass;

						var white = new FunkinSprite().makeGraphic(1, 1, 0xffffffff);
						white.scale.set(1280, 720);
						white.updateHitbox();
						white.scale.set(1280 * 2, 720 * 2);
						white.scrollFactor.set();
						white.zoomFactor = 0;
						white.alpha = 0.6;
						insert(members.indexOf(bg3), white);
						FlxTween.num(white.alpha, 0, 1, {}, (val:Float) -> {
							white.alpha = val;
						});

						var white_1 = new FunkinSprite().makeGraphic(1, 1, 0xffffffff);
						white_1.scale.set(1280, 720);
						white_1.updateHitbox();
						white_1.scale.set(1280 * 2, 720 * 2);
						white_1.scrollFactor.set();
						white_1.zoomFactor = 0;
						white_1.alpha = 0.25;
						add(white_1);
						FlxTween.num(white_1.alpha, 0, 1, {}, (val:Float) -> {
							white_1.alpha = val;
						});

						var black = new FunkinSprite().makeGraphic(1, 1, 0xff000000);
						black.scale.set(1280, 720);
						black.updateHitbox();
						black.scale.set(1280 * 2, 720 * 2);
						black.scrollFactor.set();
						black.zoomFactor = 0;
						black.alpha = 0;
						black.cameras = [versionCam];
						add(black);
						FlxTween.num(black.alpha, 1, 1, {ease:FlxEase.quartIn}, (val:Float) -> {
							black.alpha = val;
						});

						FlxTween.num(FlxG.camera.zoom, 2, 1, {ease:FlxEase.quartIn, onComplete: (_) -> {
							if (buttonId != '0')
								FlxG.switchState(Type.createInstance(stateClass, []));
								else {
									PlayState.loadWeek({
										name: "stella",
										id: "stella",
										sprite: null,
										chars: [null, null, null],
										songs: [
											{name: 'arctic', hide: false},
											{name: 'blizzard', hide: false},
											{name: 'under-stress', hide: false},
											{name: 'descent', hide: false}
										],
										difficulties: ['hard']
									}, 'hard');
								FlxG.switchState(new PlayState());
							}}}, (val:Float) -> {
							FlxG.camera.zoom = val;
						});

						var follow = [0, 0];
						switch (choose) {
							case '0':
								follow = [150, 25];
							case '1':
								follow = [150, 125];
							case '2':
								follow = [250, 200];
							case '3':
								follow = [-200, 50];
						}
						FlxTween.tween(FlxG.camera.scroll, {x: follow[0], y: follow[1]}, 1, {ease:FlxEase.quartIn});

						return true;
					}
				}
			} else {
				button.playAnim('normal', true);
			}
			return false;
		} else {
			if (FlxG.mouse.justPressed)
				FlxG.switchState(Type.createInstance(state, []));
		}
	}

	var clicked = handleButton(options, OptionsMenu, '2') || handleButton(storyMode, StoryMenuState, '0');

	defaultCamZoom = choose != '' ? 1.05 : 1;
	switch (choose) {
		case '0':
			camOffset = [10, 10];
		case '1':
			camOffset = [10, 10];
		case '2':
			camOffset = [10, 10];
		case '3':
			camOffset = [-15, 10];
		default:
			camOffset = [0, 0];
	}

	if (hoveredButton == null && choose != '') choose = '';

	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		Mouse.cursor = 'auto';
		persistentUpdate = !(persistentDraw = true);
	}

	if (controls.BACK || FlxG.mouse.justPressedRight) {
		FlxG.switchState(new TitleState());
		Mouse.cursor = 'auto';
	}
}

function destroy() {
	FlxG.camera.bgColor = 0xFF000000;
	FlxG.bitmap.remove(bitmap);
}