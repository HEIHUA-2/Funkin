var holdTime;

function onStartSong() {
	holdTimeUpdate();
	Conductor.onBPMChange.add(holdTimeUpdate);

	this.animation.onFrameChange.add((animName:String) -> {
		this.holdTime = holdTime;
	});
}

function holdTimeUpdate()
	holdTime = 750 / Conductor.stepCrochet;

function destroy()
	Conductor.onBPMChange.remove(holdTimeUpdate);