import flixel.text.FlxTextFormat;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextBorderStyle;
import openfl.system.Capabilities;

var multiplying = Math.min(Capabilities.screenResolutionX / FlxG.width, Capabilities.screenResolutionY / FlxG.height);

var H1 = new FlxTextFormat(0xA7F8FF, null, null, 0xff557799);
H1.format.size = 90 * multiplying;
H1.format.font = Assets.getFont(Paths.font('KeinannMaruPOP.woff')).fontName;

var format_red = new FlxTextFormat(0xFF4444, null, null, 0xff552222);
format_red.format.size = 40 * multiplying;
format_red.format.font = Assets.getFont(Paths.font('KeinannMaruPOP-Bold-Italicized.woff')).fontName;

var format_yellow = new FlxTextFormat(0xFFFF44, null, null, 0xff555522);

function create()
{
	disclaimer.font = Paths.font('KeinannMaruPOP.woff');
	@:privateAccess disclaimer._defaultFormat.leading = -10 * multiplying;

	titleAlphabet.destroy();
}

function postCreate()
{
	disclaimer.applyMarkup("%！！！WARNING！！！%

此模组仍在开发中，未来会带来更多内容！
游玩时如果遇到 #性能问题# 或觉得 #难度过高#？
别担心，在 #设置菜单# 中新增了 *Starry Options* 来调整关于这个模组的相关设置。

This mod is still in development—more content coming!
Experiencing #performance issues# or finding it #too difficult#?
Don’t worry—we’ve added *Starry Options* under #Options# for
mod-specific adjustments.


", // 为什么要空那么多行才能显示完整？
		[
			new FlxTextFormatMarkerPair(H1, "%"),
			new FlxTextFormatMarkerPair(format_red, "*"),
			new FlxTextFormatMarkerPair(format_yellow, "#")
		]
	);
	disclaimer.fieldWidth *= multiplying;
	disclaimer.antialiasing = true;
	disclaimer.borderSize = 2.5 * multiplying;
	disclaimer.borderColor = 0xff555555;
	disclaimer.size *= multiplying;
	disclaimer.scale.set(1 / multiplying, 1 / multiplying);

	disclaimer.screenCenter();
}