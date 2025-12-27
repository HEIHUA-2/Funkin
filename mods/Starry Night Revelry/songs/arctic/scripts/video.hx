// import hxvlc.flixel.FlxVideoSprite;
// import sys.thread.Thread;

// var video:FlxVideoSprite;

// function postCreate() {
// 	var thread = Thread.create(() -> {
// 		video = new FlxVideoSprite();
// 		video.load(Assets.getPath(Paths.video('flow')));
// 		video.play();
// 		add(video);
// 	});
// }

// function onSubstateOpen(event)
// 	if (video != null && paused)
// 		video.pause();

// function onSubstateClose(event)
// 	if (video != null && paused)
// 		video.resume();

// function focusGained()
// 	if (video != null && !paused)
// 		video.resume();