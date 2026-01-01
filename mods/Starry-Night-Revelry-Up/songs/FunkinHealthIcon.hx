import haxe.Timer;
import flixel.util.FlxTimer;

var timer = new FlxTimer();

function postCreate()
{
	for (icon in iconArray)
	{
    if (icon.curCharacter == 'stella')
    {
      var iconName = icon.curCharacter;
      var iconAngle = false;

			icon.animation.callback = () -> {
				if (iconName != icon.curCharacter)
					return;

				icon.angle = 0;
				if (icon.animation.name == 'winning') {
					icon.angle = iconAngle ? -1 : 1;
					iconAngle = !iconAngle;
				}
      }
    }

		icon.bump = null;

		icon.updateBump = () -> {
			var defaultScale = icon.defaultScale;
			var scale = icon.scale;
			icon.scale.set(CoolUtil.fpsLerp(scale.x, defaultScale, 0.1), CoolUtil.fpsLerp(scale.y, defaultScale, 0.1));
    };

		var iconOffsetY = 0;
		icon.onDraw = () -> {
			iconOffsetY = -(icon.scale.y - icon.defaultScale) * 100;
			icon.y += iconOffsetY;
			icon.draw();
      icon.y -= iconOffsetY;
    }
	}
}

function beatHit_stella(beat) {
	for (icon in iconArray)
	{
		if (icon.curCharacter == 'stella')
		{
			var beatStep = Math.ceil(Conductor.getTimeInBeats(125, Conductor.curChangeIndex));

			if (beat % 2 == 2 - beatStep) {
				timer.start(Conductor.getBeatsInTime(beatStep) * 0.001 - 0.125, () -> {
					if (icon.animation.name == 'neutral')
						icon.animation.play('neutral');
				});
			}
		}
	}
}

function beatHit_bf(beat) {
	for (icon in iconArray)
		if (icon.curCharacter == 'bf' && beat % 2 == 0 && icon.animation.name == 'neutral')
			icon.animation.play('neutral');
}

Conductor.onBeatHit.add(beatHit_stella);
Conductor.onBeatHit.add(beatHit_bf);

function beatHit(beat) {
	if (beat % 2 == 0)
		for (icon in iconArray)
		{
			icon.scale.x += 0.12 * icon.defaultScale;
			icon.scale.y *= 0.9;
		}
}

function destroy() {
	Conductor.onBeatHit.remove(beatHit_stella);
	Conductor.onBeatHit.remove(beatHit_bf);
}