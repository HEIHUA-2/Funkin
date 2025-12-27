function postCreate() {
	addVirtualPad('LEFT_FULL', 'A_B');
}

function postUpdate(elapsed) {
	final mousePos = FlxG.mouse.getScreenPosition(FlxG.camera);
	if (FlxG.mouse.justPressed && mousePos.x > 1000 && mousePos.y > 580)
		addVirtualPad('LEFT_FULL', 'A_B');
}
// 以防止有其他种类设备所以不限制仅在安卓触发，反正报错了也只在CMD里面报错LOL