import funkin.game.ComboRating;

static var healthbarNew:FunkinSprite;
static var healthbarBGNew:FunkinSprite;

var healthBarPercent:Float;

static var healthColor:CustomShader;

static var healthLeftColor:Int;
static var healthRightColor:Int;

function postCreate() {
	comboRatings = [
		new ComboRating(0, "F-", 0xFFba0000),
		new ComboRating(0.125, "F", 0xFFFF0000),
		new ComboRating(0.25, "F+", 0xFFFF2000),
		new ComboRating(0.5, "E", 0xFFFF4000),
		new ComboRating(0.6, "E+", 0xFFFF6600),
		new ComboRating(0.7, "D", 0xFFFFa200),
		new ComboRating(0.7, "D+", 0xFFFFb800),
		new ComboRating(0.8, "C", 0xFFFFe700),
		new ComboRating(0.825, "C+", 0xFFFFFF00),
		new ComboRating(0.85, "B", 0xFFdfff00),
		new ComboRating(0.875, "B+", 0xFFbcff00),
		new ComboRating(0.9, "A", 0xFF90ff00),
		new ComboRating(0.925, "A+", 0xFF00ff00),
		new ComboRating(0.95, "S", 0xFFa7f8ff),
		new ComboRating(0.975, "S+", 0xFFa7f8ff),
		new ComboRating(1, "S++", 0xFFa7f8ff)
	];


	for (text in [scoreTxt, missesTxt, accuracyTxt]) {
		text.borderSize = 1.25;
		updateTextSize(text, 1, true);
		text.antialiasing = false;
	}

	healthBarBG.visible = healthBar.visible = false;
	healthBar.numDivisions = 469.53125;


	healthColor = new CustomShader('color_percent');

	healthbarNew = new FunkinSprite(0,639).loadGraphic(Paths.image('game/healthBarMain'));
	healthbarNew.scrollFactor.set();
	healthbarNew.x = 1280 / 2 - center(healthbarNew, 'x');
	healthbarNew.cameras = [camHUD];
	healthbarNew.antialiasing = false;
	insert(members.indexOf(healthBar), healthbarNew);
	add(healthbarNew);

	healthbarBGNew = new FunkinSprite(0,617).loadGraphic(Paths.image('game/healthBarCover'));
	healthbarBGNew.scrollFactor.set();
	healthbarBGNew.scale.set(0.5, 0.5);
	healthbarBGNew.updateHitbox();
	healthbarBGNew.x = 1280 / 2 - center(healthbarBGNew, 'x');
	healthbarBGNew.cameras = [camHUD];
	healthbarBGNew.antialiasing = true;
	insert(members.indexOf(healthBar) + 1, healthbarBGNew);
	add(healthbarBGNew);

	healthbarNew.shader = healthColor;

	if (downscroll) {
		iconP1.y -= 25;
		healthbarNew.y -= 40;
		healthbarBGNew.y -= 22.5;
	}
}


function postUpdate(elapsed:Float) {
	healthLeftColor = Options.colorHealthBar ? dad.iconColor : (opponentMode ? 0xFF66FF33 : 0xFFFF0000);
	healthRightColor = Options.colorHealthBar ? boyfriend.iconColor : (opponentMode ? 0xFFFF0000 : 0xFF66FF33);

	healthBarPercent = lerp(healthBarPercent, health / maxHealth * 100, 1 / 60 * 40);
	healthBar.percent = healthBarPercent;

	healthColor.healthBarColorLeft = colorRGBFloat(healthLeftColor);
	healthColor.healthBarColorRight = colorRGBFloat(healthRightColor);
	healthColor.percent = healthBar.percent;

	// dad.exists = false;
}
// 极简主义者