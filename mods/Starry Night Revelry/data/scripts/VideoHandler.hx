import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
import hxvlc.flixel.FlxVideoSprite;

var videoMap = new CustomShader('video_map');

public function addVideo(path, map)
{
	if (map == null)
  {
		var video = FlxVideo().play(Paths.video(path));

    video.bitmap.onEndReached.add(function() {
      video.bitmap.dispose();
      remove(video);

      if (_onEndReached != null)
        _onEndReached();
		});
		add(video);

		return video;
  }
  else
  {
		var video = FlxVideo();
		video.play('flow');
		video.load(Assets.getPath(Paths.video(path)));

		video.bitmap.onEndReached.add(function() {
			video.bitmap.dispose();
			remove(video);

			if (_onEndReached != null)
				_onEndReached();
		});

		map.shader = videoMap;

		video.bitmap.onTextureSetup.add(function() {
			videoMap.video = video.bitmap.bitmapData;
		});

		return video;
  }
}