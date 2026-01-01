import funkin.game.ComboRating;

public var comboRatingSprites = new FlxSpriteGroup();

public var healthbarNew:FunkinSprite;
public var healthbarBGNew:FunkinSprite;

var healthBarPercent:Float = 1;

var starryComboRatingBack:FunkinSprite;
var starryComboRight:FunkinSprite;
var starryComboCentre:FunkinSprite;
var starryComboLeft:FunkinSprite;
var starryRating:FunkinSprite;

public var healthColor:CustomShader = new CustomShader('color_percent');

function postCreate() {
	comboRatings = [
		new ComboRating(0,    "F-",  0xFF4A5C6A), // 深灰蓝（基础冷色调）
		new ComboRating(0.125,"F",   0xFF5D7A8C), // 冷灰蓝
		new ComboRating(0.25, "F+",  0xFF6B8EA8), // 稍亮的冷蓝
		new ComboRating(0.5,  "E",   0xFF7AA3C2), // 冰蓝色
		new ComboRating(0.6,  "E+",  0xFF88B8E0), // 浅冰蓝

		// 从D级开始引入微妙变化
		new ComboRating(0.7,  "D",   0xFF96CDFF), // 淡冰蓝
		new ComboRating(0.725,  "D+",  0xFF8AC8E6), // 带极光绿的蓝

		// C级 - 引入冰川蓝绿色调
		new ComboRating(0.8,  "C",   0xFF7FD4D4), // 冰川蓝绿
		new ComboRating(0.825,"C+",  0xFF6AD8D8), // 明亮的冰川绿

		// B级 - 加入北极光紫色调
		new ComboRating(0.85, "B",   0xFF9A86E0), // 淡紫蓝色
		new ComboRating(0.875,"B+",  0xFFA88FFF), // 紫晶色

		// A级 - 极光效果增强
		new ComboRating(0.9,  "A",   0xFFB899FF), // 紫罗兰色
		new ComboRating(0.925,"A+",  0xFFC6A3FF), // 粉紫色

		// S级 - 绚丽的极光色彩
		new ComboRating(0.95, "S",   0xFFD4ADFF), // 粉紫极光色
		new ComboRating(0.975,"S+",  0xFFFFB6E6), // 粉红色极光（雪地日出效果）

		// S++ - 最高级的冰雪极光效果
		new ComboRating(1,    "S++", 0xFFFFD1F0)  // 淡粉极光白（冰雪反射阳光）
	];


	for (text in [scoreTxt, missesTxt, accuracyTxt]) {
		text.y += 10;
		text.borderSize = 1.25;
		updateTextSize(text, 1, true);
		text.antialiasing = false;
	}

	starryComboRatingBack = new FunkinSprite(0, 0, Paths.image('game/background'));
	starryComboRatingBack.antialiasing = true;
	starryComboRatingBack.addAnim('0', '0', 12);
	starryComboRatingBack.addAnim('1', '0011');
	starryComboRatingBack.playAnim('1', true);

	starryComboRight = new FunkinSprite(0, 0, Paths.image('game/number_right'));
	starryComboRight.antialiasing = true;
	for (i in 0...10) starryComboRight.addAnim(i, i, 12);
	starryComboRight.addAnim('11', '0/0011');
	starryComboRight.playAnim('11', true);

	starryComboCentre = new FunkinSprite(0, 0, Paths.image('game/number_centre'));
	starryComboCentre.antialiasing = true;
	for (i in 0...10) starryComboCentre.addAnim(i, i, 12);
	starryComboCentre.addAnim('11', '0/0011');
	starryComboCentre.playAnim('11', true);

	starryComboLeft = new FunkinSprite(0, 0, Paths.image('game/number_left'));
	starryComboLeft.antialiasing = true;
	for (i in 0...10) starryComboLeft.addAnim(i, i, 12);
	starryComboLeft.addAnim('11', '0/0011');
	starryComboLeft.playAnim('11', true);

	starryRating = new FunkinSprite(0, 0, Paths.image('game/rating'));
	starryRating.antialiasing = true;
	starryRating.addAnim('sick', 'sick', 12);
	starryRating.addAnim('good', 'good', 12);
	starryRating.addAnim('bad', 'bad', 12);
	starryRating.addAnim('shit', 'shit', 12);
	starryRating.addAnim('1', 'bad/0011');
	starryRating.playAnim('1', true);
	
	for (obj in [starryComboRatingBack, starryRating, starryComboRight, starryComboCentre, starryComboLeft]) comboRatingSprites.add(obj);

	comboRatingSprites.cameras = [camHUD];
	insert(0, comboRatingSprites);

	healthbarNew = new FunkinSprite(0, 560, Paths.image('game/healthBar'));
	healthbarNew.scrollFactor.set();
	healthbarNew.x = 1280 / 2 - center(healthbarNew, 'x');
	healthbarNew.cameras = [camHUD];
	healthbarNew.antialiasing = true;
	insert(members.indexOf(healthBar), healthbarNew);

	healthbarBGNew = new FunkinSprite(0, 560, Paths.image('game/healthBarBG'));
	healthbarBGNew.scrollFactor.set();
	healthbarBGNew.x = 1280 / 2 - center(healthbarBGNew, 'x');
	healthbarBGNew.cameras = [camHUD];
	healthbarBGNew.antialiasing = true;
	insert(members.indexOf(healthBar) + 1, healthbarBGNew);

	healthbarNew.shader = healthColor;

	if (downscroll) {
		healthbarNew.y += 15;
		healthbarBGNew.y += 15;
	}

	comboGroup.exists = false;

	healthBarBG.visible = healthBar.visible = false;
  healthBar.unbounded = true;
	healthBar.parent = healthBarPercent;
	healthBar.percent = 50;

	healthBarColorUpdate();
}

function onPostCountdown(e) {
	var sprite = e.sprite;
	if (e.spriteTween != null) e.spriteTween.active = false;

	if (sprite != null) FlxTween.num(1, 0.7, Conductor.crochet / 1000, {ease: FlxEase.quartOut}, (val:Float) -> {
		sprite.scale.set(val, val);
	});
	if (sprite != null) FlxTween.tween(sprite, {y: sprite.y + 100, alpha: 0}, Conductor.crochet / 1000, {
		ease: FlxEase.quartIn,
		onComplete: function(twn:FlxTween) {
			sprite.destroy();
			remove(sprite, true);
		}
	});
}

var scoreTable:Array<Int> = [
	for (diff in 5...hitWindow) {
		var expArg = -0.080 * (diff - 54.99);
		var sigmoid = 1.0 / (1.0 + Math.exp(expArg));
		Std.int(500.0 * (1.0 - sigmoid) + 9);
	}
];

var digitTable:Array<Array<Int>> = [
	for (i in 0...1000) [
		i % 10, Std.int(i / 10) % 10, Std.int(i / 100) % 10
	]
];

function onPlayerHit(event:NoteHitEvent):Void {
	if (event.note.isSustainNote) return;

	event.displayRating = event.displayCombo = false;

	event.score = scoreTable[CoolUtil.bound(Math.round(Math.abs(Conductor.songPosition - event.note.strumTime)), 5, 180)];

	var digits = digitTable[combo + 1];

	starryComboRatingBack.playAnim('0', true);
	starryComboRight.playAnim(digits[0], true);
	starryComboCentre.playAnim(digits[1], true);
	starryComboLeft.playAnim(digits[2], true);
	starryRating.playAnim(event.rating, true);
}

function postUpdate(elapsed:Float) {
	healthBarPercent = CoolUtil.fpsLerp(healthBarPercent, health * 50, 0.125);
	healthColor.percent = healthBar.percent = healthBarPercent;
}

public function healthBarColorUpdate() {
	healthColor.healthBarColorLeft = colorRGBFloat(dad.iconColor);
	healthColor.healthBarColorRight = colorRGBFloat(boyfriend.iconColor);
}
// 这下极简不了一点了