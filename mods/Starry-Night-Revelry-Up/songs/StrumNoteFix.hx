import haxe.Timer;

public var note_limit = true;
public var note_limit_scale = 1;

var _t = 0;

var timer:Timer;

function create() {
	addNoteSLen(Conductor.stepCrochet / 8);

	timer = new Timer(500);
	timer.run = () -> {
		updateNoteLimits();
	};
}

function postCreate() {
	addNoteSLen(-Conductor.stepCrochet / 8);

	for (strumLine in strumLines) {
		for (strum in strumLine.members) {
			strum.animation.onPlay.add(function(animName:String) {
				if (animName == 'confirm') {
					strum.scale.set(0.735 * strumLine.strumScale, 0.735 * strumLine.strumScale);
				} else {
					strum.scale.set(0.7 * strumLine.strumScale, 0.7 * strumLine.strumScale);
				}
			});
		}
	}
}


var lastNoteTime:Float = -1;
var lastNoteType:String = '';

function onPlayerHit(event:NoteHitEvent):Void {
	final note = event.note;

	if (note.isSustainNote)
		return;

	if (lastNoteTime == note.strumTime && lastNoteType == event.noteType) {
		event.animCancelled = true;
		return;
	}

	lastNoteTime = note.strumTime;
	lastNoteType = event.noteType;
}


function onDadHit(event)
	if (event.isSustainNote && event.note.animation.name == 'holdend') event.animCancelled = true;


function onPostNoteCreation(e)
	e.note.gapFix = 1;


function addNoteSLen(len)
	for (str in strumLines)
		for (note in str.data.notes)
			note.sLen += len;

public function updateNoteLimits() {
	var sh = FlxG.height;
	var sc = Conductor.stepCrochet;
	var hz = camHUD.zoom;
	var nsw = Note.swagWidth;
	var denominatorFactor = 0.45 * hz;

	var sl = strumLines.members;
	var sln = sl.length;

	var i = 0;
	while (i < sln) {
		var strumLine = sl[i];
		var members = strumLine.members;
		var mcount = members.length;

		var minY = 1e9;
		var minSpeed = 1e9;

		var j = mcount;
		while (j-- > 0) {
			var strum = members[j];
			var y = strum.y;
			var speed = strum.getScrollSpeed();

			if (y < minY) minY = y;
			if (speed < minSpeed) minSpeed = speed;
		}

		var denom = denominatorFactor * minSpeed;
		strumLine.notes.limit = (sh - minY) / denom + sc;
		strumLine.notes.limit *= note_limit_scale;

		i++;
	}
}

function destroy()
	timer.stop();