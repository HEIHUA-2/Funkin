function create() {
	addNoteLen(Conductor.stepCrochet / 2);
}

function postCreate() {
	addNoteLen(-Conductor.stepCrochet / 2);
	
	for (strumLine in strumLines) {
		for (strum in strumLine.members) {
		}
	}
}

function postUpdate(elapsed:Float) {
	for (strumLine in strumLines) {
		for (strum in strumLine.members) {
			if (strum.getAnim() == 'confirm') {
				strum.scale.set(0.735, 0.735);
				if (strum.animation.curAnim.finished && strumLine.cpu) strum.playAnim('static', false);
			} else {
				strum.scale.set(0.7, 0.7);
			}
		}
	}
}


function addNoteLen(len) {
	// for (note in player.data.notes) if (note.sLen > Conductor.stepCrochet + 1) note.sLen += len;
	for (str in strumLines) for (note in str.data.notes) note.sLen += len;
}
// 让长条不再短一格，并且命中箭头之后动画优化