function postCreate() {
	if (!PlayState.opponentMode && !PlayState.coopMode) cpu.onHit.add((e) -> {
		e.healthGain = !e.note.isSustainNote ? 0.02 : 0.01;
		var predictedHealth = health - e.healthGain;
		if (predictedHealth < 0.1 && health >= 0.1)
			e.healthGain = health - 0.1;
		else if (health < 0.1)
			e.healthGain = 0;
	});
}

event.createStep(576, () -> {
	camZoomingInterval = 2;
});

event.createStep(1152, () -> {
	camZoomingInterval = 4;
});

event.createStep(1168, () -> {
	camZoomingInterval = 2;
});

event.createStep(1344, () -> {
	camZoomingInterval = 1;
});

event.createStep(1728, () -> {
	camZoomingInterval = 4;
});

event.createStep(1824, () -> {
	camZoomingInterval = 2;
});

event.createStep(2112, () -> {
	camZoomingInterval = 4;
});

event.createStep(2304, () -> {
	camZoomingInterval = 114514;
});