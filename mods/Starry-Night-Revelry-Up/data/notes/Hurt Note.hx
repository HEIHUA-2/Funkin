import openfl.display.BlendMode;

importScript('data/scripts/FunkinShaderQuality');

public var vcr:CustomShader;
public var camHurtNote:HudCamera;

var masking:FunkinSprite;
var maskingAlpha;

function create() {
	if (!FlxG.save.data.starry_hurt_note) return;

	camHurtNote = addCamera(getCamIndex(camHUD) + 1, false);

	vcr = shaderQuality('vcr_note', [camHurtNote]);
	vcr.amount = 2;

	if (FlxG.save.data.starry_hurt_note)
		FlxG.signals.preDraw.add(refresh);

	if (FlxG.save.data.starry_VCR_Note) camHurtNote.addShader(vcr);
}


function postCreate() {
	if (!FlxG.save.data.starry_hurt_note) return;

	masking = new FunkinSprite().makeGraphic(1, 1, 0xffffffff);
	masking.scale.set(1280, 720);
	masking.updateHitbox();
	masking.scrollFactor.set();
	masking.zoomFactor = 0;
	masking.alpha = 0;
	masking.cameras = [camOther];
	add(masking);
	masking.blend = BlendMode.SUBTRACT;
}


function onNoteCreation(event) {
	if (event.noteType != 'Hurt Note') return;

	if (!FlxG.save.data.starry_hurt_note) {
		event.note.strumTime -= Math.POSITIVE_INFINITY;
		event.note.exists = event.note.active = event.note.visible = false;
		return;
	}

	event.cancel(true);
	event.note.avoid = true;

	event.note.frames = Paths.getFrames(event.noteSprite);

	final colors = ["purple", "blue", "green", "red"];
	event.note.animation.addByPrefix('scroll', colors[event.strumID % 4] + '0');
	event.note.animation.addByPrefix('hold', 'hold piece');
	event.note.animation.addByPrefix('holdend', 'hold end');

	event.note.scale.set(event.noteScale, event.noteScale);
	event.note.antialiasing = false;

	event.note.earlyPressWindow = !event.note.isSustainNote ? 1 : 0.1; // 175ms
	event.note.latePressWindow = !event.note.isSustainNote ? 0.2 : 0.1; // 35ms

	event.note.cameras = [camHurtNote];
}


function onPlayerMiss(event) {
	if (event.noteType != 'Hurt Note') return;

	event.cancel();
	event.note.strumLine.deleteNote(event.note);
}


function onPlayerHit(event) {
	if (event.noteType != 'Hurt Note') return;

	event.countAsCombo = event.showRating = event.showSplash = false; 
	event.strumGlowCancelled = true;
	event.healthGain = -0.4;

	maskingAlpha += 0.75;
	FlxTween.num(FlxG.camera.zoom, FlxG.camera.zoom + 0.2, Conductor.getMeasuresInTime(1, Conductor.curChangeIndex) * 0.001 * 0.1875, {ease:FlxEase.sineOut}, (val:Float) -> {
		FlxG.camera.zoom = val;
	});
	var sound = FlxG.sound.play(Paths.sound('TV_Static'));
	FlxTween.num(0.6, 0, 2.5, {}, (val:Float) -> {
		sound.volume = val;
	});

	var diff = CoolUtil.bound(Math.abs(Conductor.songPosition - event.note.strumTime), 5.0, 250.0);
	var expArg = -0.080 * (diff - 54.99);
	var sigmoid = 1.0 / (1.0 + Math.exp(expArg));
	event.score = -Std.int(1000.0 * (1.0 - sigmoid) + 9);

	//FlxG.sound.play(Paths.sound('STEEL PIPE LANDING ON THE GROUND')); //禁止取消注释
}

function postUpdate(elapsed) {
	if (!FlxG.save.data.starry_hurt_note) return;

	var __loopSprite:Note;
	var __time = Conductor.songPosition;
	var limit;

	vcr.enabled = false;
	for (strumLine in strumLines) {
		var i = strumLine.notes.length - 1;
		limit = strumLine.notes.limit;
		while (i >= 0) {
			__loopSprite = strumLine.notes.members[i];
			if (__loopSprite.strumTime - __time > limit)
				break;
			if (__loopSprite.noteType == 'Hurt Note') {
				vcr.enabled = true;
				break;
			}
			i--;
		}
	}
}


function destroy() {
	if (FlxG.save.data.starry_hurt_note)
		FlxG.signals.preDraw.remove(refresh);
}


function refresh() {
	vcr.iTime = FlxG.game.ticks * 0.001;
	camHurtNote.zoom = camHUD.zoom;
	camHurtNote.downscroll = camHUD.downscroll;

	maskingAlpha = lerp(maskingAlpha, 0, 1 / 60);
	if (maskingAlpha <= 0.001)
		maskingAlpha = 0;
	masking.alpha = maskingAlpha;
}
// 大师优化大师中的优化大师，我服了