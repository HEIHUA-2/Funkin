function onSongEnd() {
	if (PlayState.isStoryMode) {
		Flags.MOD_REDIRECT_STATES.set('MainMenuState', 'starry/MainMenuState');
		Flags.MOD_REDIRECT_STATES.set('StoryMenuState', 'starry/MainMenuState');
		Flags.DEFAULT_MENU_MUSIC = 'freakyMenu';

		FlxG.save.data.starry = true;
  } // 你说的对，但是我不会管任何通关的方式
}