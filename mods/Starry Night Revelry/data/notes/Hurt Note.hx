import openfl.display.BlendMode;

static var vcr:CustomShader;
static var camHurtNote:HudCamera;

var masking:FunkinSprite;
var maskingAlpha;

function create() {
	if (!FlxG.save.data.starry_hurt_note) return;
	vcr = new CustomShader('vcr_add');
	vcr.amount = 2;


	camHurtNote = addCamera(getCamIndex(camHUD) + 1, false);

	if (FlxG.save.data.note_starry_vcrshader) camHurtNote.addShader(vcr);
}


function postCreate() {
	masking = new FunkinSprite().makeGraphic(1, 1, 0xffffffff);
	masking.scale.set(1280, 720);
	masking.updateHitbox();
	masking.scrollFactor.set(0, 0);
	masking.zoomFactor = 0;
	masking.alpha = 0;
	masking.cameras = [camOther];
	add(masking);
	masking.blend = BlendMode.SUBTRACT;
}


function onNoteCreation(event) {
	if (event.noteType != "Hurt Note") return;

	if (!FlxG.save.data.starry_hurt_note) {
		event.note.strumTime -= 999999;
		event.note.exists = event.note.active = event.note.visible = false;
		return;
	}

	event.cancel(true);
	event.note.avoid = true;

	event.note.frames = Paths.getFrames(event.noteSprite);

	switch(event.strumID % 4) {
	case 0:
		event.note.animation.addByPrefix('scroll', 'purple0');
	case 1:
		event.note.animation.addByPrefix('scroll', 'blue0');
	case 2:
		event.note.animation.addByPrefix('scroll', 'green0');
	case 3:
		event.note.animation.addByPrefix('scroll', 'red0');
	}

	event.note.animation.addByPrefix('hold', 'hold piece');
	event.note.animation.addByPrefix('holdend', 'hold end');

	// if (!event.note.isSustainNote)
		// event.note.frameOffset.x += 52.5;

	event.note.scale.set(event.noteScale, event.noteScale);
	event.note.antialiasing = true;

	event.note.earlyPressWindow = 1; // 250ms
	event.note.latePressWindow = 0.2; // 50ms

	event.note.cameras = [camHurtNote];
}


function onPlayerMiss(event)
	if (event.noteType == "Hurt Note") {
		event.cancel(true);
		event.note.strumLine.deleteNote(event.note);
	}


function onPlayerHit(event)
	if (event.noteType == "Hurt Note") {
		event.countAsCombo = event.showRating = event.showSplash = false; 
		event.strumGlowCancelled = true;
		health -= 0.4;
		health -= 0.023;

		maskingAlpha += 0.75;
		FlxTween.num(FlxG.camera.zoom, FlxG.camera.zoom + 0.2, sectionCrochet * 0.1875, {ease:FlxEase.sineOut}, (val:Float) -> {
			FlxG.camera.zoom = val;
		});
		var sound = FlxG.sound.play(Paths.sound('noise'));
		FlxTween.num(0.6, 0, 2.5, {}, (val:Float) -> {
			sound.volume = val;
		});
		//FlxG.sound.play(Paths.sound('steelPipe')); //禁止取消注释
	}


function postUpdate(elapsed:Float) {
	vcr.iTime = gameTime;
	camHurtNote.zoom = camHUD.zoom;
	camHurtNote.downscroll = camHUD.downscroll;

	maskingAlpha = lerp(maskingAlpha, 0, 1 / 60);
	masking.alpha = maskingAlpha;
}
//大师优化大师中的优化大师，我服了