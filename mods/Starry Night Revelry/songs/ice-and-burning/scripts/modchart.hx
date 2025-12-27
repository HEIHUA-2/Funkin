import funkin.backend.scripting.ScriptPack;

var sectionCrochets = 1.2;

function postCreate()
{
	if (!FlxG.save.data.starry_modchart)
		return;

	importScript("data/scripts/ModChartManager.hx");

	setupModifiers();

	initModchart();
}

function setupModifiers()
{
	for (i in 0...4)
	{
		createModifier("y"+i, 0, "
			y += y"+(i)+"_value + curPos * y"+(i)+"_value / 50.0;
		", 0, i);
		createModifier("y"+(i+4), 0, "
			y += y"+(i+4)+"_value + curPos * y"+(i+4)+"_value / 50.0;
		", 1, i);
	}

	createModifier("zbf", 0, "
		x += zbf_value;
		z += zbf_value;
	", 1);

	createModifier("zdad", 0, "
		x -= zdad_value;
		z += zdad_value;
	", 0);

	createModifier("z", 0, "
		z += z_value;
	");

	createModifier("sway", 0, "
		x += cos(curPos / 100.0) * sway_value;
	");

	createModifier("warpX", 0, "
		x += sin((songPosition / 5000.0 + curPos / 300.0)) * warpX_value * (curPos / 720.0);
	", 0);

	createModifier("warpXX", 0, "
		float warpXXvalue = strumID - 4.0;
			if (warpXX_value < 0.0)
				warpXXvalue = -strumID;
		x += (warpXXvalue - 1.5) * warpXX_value + sin(curPos / 50.0) * warpXX_value * 4.0 * warpXXvalue;
	");

	createModifier("shakeXY", 2, "
		x += sin((songPosition / 131.0 + curPos) * 53.0 + strumID) * shakeXY_value;
		y += sin((songPosition / 66.0 + curPos) * 123.0 + strumID) * shakeXY_value;
		z += sin((songPosition / 99.0 + curPos) * 77.0 + strumID) * shakeXY_value * 2.0;
	", 0);

	createModifier("shakeXYBF", 0, "
		if (curPos != 0.0)
		{
			x += sin((songPosition / 131.0 + curPos) * 53.0 + strumID) * shakeXYBF_value;
			y += sin((songPosition / 66.0 + curPos) * 123.0 + strumID) * shakeXYBF_value;
			z += sin((songPosition / 99.0 + curPos) * 77.0 + strumID) * shakeXYBF_value * 2.0;
		}
	", 1);
}

function stepHit(step:Int) {
	if (!FlxG.save.data.starry_modchart)
		return;

	switch (step) {
	case 272:
		modifierWarpX(2);
	case 280:
		modifierWarpX(4);
	case 288:
		modifierWarpX(6);
	case 296:
		modifierWarpX(8);
	case 300:
		modifierWarpX(9);
	case 332:
		modifierWarpX(10);
	case 364:
		modifierWarpX(10);
	case 364:
		modifierWarpX(10);
  }

	if (step >= 304 && step < 400 && step % 8 == 0)
	{
		modifierWarpX(10);
	}

	if (step >= 448 && step < 704 && step % 4 == 0)
	{
		modifierWarpX(6);
	}

	if (step >= 768 && step < 960 && step % 4 == 0)
	{
		modifierWarpX(6);
	}

	if ((step >= 960 && step < 1472) && (step % 8 == 0 || step % 32 == 28))
	{
		modifierWarpX(2);
	}

	if ((step >= 1472 && step < 1712) && step % 8 == 0)
	{
		modifierY(FlxG.random.int(0, 3), -30);
		modifierY(FlxG.random.int(4, 7), -30);
		modifierY(FlxG.random.int(0, 3), -30);
		modifierY(FlxG.random.int(4, 7), -30);
	}

	if ((step >= 1728 && step < 2224) && step % 4 == 0)
	{
		modifierSway(75);
		for (i in 0...8)
		{
		setModifierValue('y'+i, FlxG.random.float(-50, 50));
		tweenModifierValue('y'+i, 0, sectionCrochet / 4 - 0.035, FlxEase.quartOut);
		}
	}

	switch (step) {
	case 320:
    // tweenModifierValue('z', 3000, sectionCrochet * 8 * 0.625 - 0.035, FlxEase.quartIn);
    tweenModifierValue('shakeXY', 10, sectionCrochets * 4 - 0.035, FlxEase.quartIn);
    tweenModifierValue('shakeXYBF', 10, sectionCrochets * 4 - 0.035, FlxEase.quartIn);
	case 416:
    // tweenModifierValue('z', 0, sectionCrochets * 2 - 0.035, FlxEase.cubicOut);
    tweenModifierValue('shakeXY', 2, sectionCrochets * 2 - 0.035, FlxEase.linear);
    tweenModifierValue('shakeXYBF', 0, sectionCrochets * 2 - 0.035, FlxEase.linear);
	case 688:
    tweenModifierValue('shakeXY', 6, sectionCrochets - 0.035, FlxEase.linear);
	case 704:
    tweenModifierValue('shakeXY', 2, 0.001, FlxEase.linear);
	case 960:
    tweenModifierValue('shakeXY', 5, sectionCrochets * 2 - 0.035, FlxEase.linear);
    tweenModifierValue('shakeXYBF', 4, sectionCrochets * 2 - 0.035, FlxEase.linear);
	case 1072:
    tweenModifierValue('zbf', -25, sectionCrochets / 2 - 0.035, FlxEase.quartOut);
	case 1088:
    tweenModifierValue('zbf', 0, sectionCrochets / 4 - 0.035, FlxEase.quartOut);
	case 1328:
    tweenModifierValue('zdad', -25, sectionCrochets / 2 - 0.035, FlxEase.quartOut);
	case 1344:
    tweenModifierValue('zdad', 0, sectionCrochets / 4 - 0.035, FlxEase.quartOut);
	case 1464:
    tweenModifierValue('shakeXY', 100, sectionCrochets / 2 - 0.035, FlxEase.linear);
	case 1472:
    tweenModifierValue('shakeXY', 2, sectionCrochets / 2 - 0.035, FlxEase.quartOut);
    tweenModifierValue('shakeXYBF', 0, sectionCrochets / 2 - 0.035, FlxEase.quartOut);
	case 1728:
    tweenModifierValue('shakeXY', 5, sectionCrochets * 2 - 0.035, FlxEase.linear);
    tweenModifierValue('shakeXYBF', 4, sectionCrochets * 2 - 0.035, FlxEase.linear);
	case 2224:
    tweenModifierValue('shakeXY', 0, sectionCrochets - 0.035, FlxEase.linear);
    tweenModifierValue('shakeXYBF', 0, sectionCrochets - 0.035, FlxEase.linear);
	case 2240:
    tweenModifierValue('warpX', 25, 0.001, FlxEase.linear);
    modchartFFF = -114514;
  }
}

function postUpdate(elapsed:Float)
{
	if (Conductor.curBeatFloat >= 564 && Conductor.curBeatFloat < 656)
		camHUD.zoom = camGame.zoom;
}


var valueWarp = true;
function modifierWarpX(value)
{
	if (valueWarp)
		setModifierValue('warpXX', value);
	else
		setModifierValue('warpXX', -value);

	tweenModifierValue('warpXX', 0, sectionCrochet / 4 - 0.035, FlxEase.quartOut);
	valueWarp = !valueWarp;
}

var valueSway = true;
function modifierSway(value)
{
	if (valueWarp)
		setModifierValue('sway', value);
	else
		setModifierValue('sway', -value);

	tweenModifierValue('sway', 0, sectionCrochet / 4 - 0.035, FlxEase.bounceOut);
	valueWarp = !valueWarp;
}

function modifierY(id, value)
{
	setModifierValue('y'+id, value);

	tweenModifierValue('y'+id, 0, sectionCrochet / 2 - 0.035, FlxEase.quartOut);
}