function postUpdate(elapsed:Float) {
	if (health < 1.6) {
		iconP2._frame.frame.x = 0;
		iconP2.y = iconP1.y - 12.5;
		iconP2.x += 5;
	} else {
		iconP2._frame.frame.x = 350 / 2;
		iconP2.y = iconP1.y - 15;
	}
	iconP2._frame.frame.y = 0;
	iconP2._frame.frame.width = 350 / 2;
	iconP2._frame.frame.height = iconP2.height;
	iconP2.x -= 25;

	if (downscroll)
		iconP2.y += 25;
}
// 原神