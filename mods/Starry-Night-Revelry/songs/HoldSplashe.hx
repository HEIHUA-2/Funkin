import flixel.util.FlxTimer;
import funkin.game.SplashHandler;

var splashHoldHandler:SplashHandler;
var directionShortcuts:Array<String> = ['left', 'down', 'up', 'right'];
var splashHoldHandlerNote:Array<String> = [];
var stepCrochet;
var timer = new FlxTimer();

public var isModchart = false;

function create()
{
  splashHoldHandler = new SplashHandler();
  insert(members.indexOf(splashHandler), splashHoldHandler);
}

function postCreate()
	splashHoldHandler.getSplashGroup('default-splashHoldHandler');

function onStartSong()
{
	stepCrochetUpdate();
  Conductor.onBPMChange.add(stepCrochetUpdate);
}

function onNoteHit(e)
{
  if (e.showSplash && !e.note.isSustainNote && e.note.nextNote != null && e.note.nextNote.isSustainNote)
  {
    var sLen = 0, ns = e.note.nextNote;
    while(ns != null)
    {
      sLen += ns.sustainLength;
      ns = ns.nextSustain;
    }

    if (sLen > stepCrochet) showSplash('default-splashHoldHandler', e.note.__strum, sLen);
  }
}

var __grp:SplashGroup;
public function showSplash(name:String, strum:Strum, sLen) {
  __grp = splashHoldHandler.getSplashGroup(name);

  var splash = __grp.showOnStrum(strum);

  splash.playAnim('holding' + directionShortcuts[strum.ID]);

  var callbackHit;
  callbackHit = (e) -> {
    if (e.note.strumID == strum.ID && e.note.animation.name == 'holdend')
    {
      splash.playAnim('end' + directionShortcuts[strum.ID]);
      strum.strumLine.onHit.remove(callbackHit);
    }
  };

  var callbackMiss;
  callbackMiss = (e) -> {
    if (e.note.strumID == strum.ID)
    {
      splash.animation.finishCallback();
      strum.strumLine.onHit.remove(callbackHit);
      strum.strumLine.onMiss.remove(callbackMiss);
    }
  };

  strum.strumLine.onHit.add(callbackHit);
	strum.strumLine.onMiss.add(callbackMiss);
  
	timer.start((sLen + hitWindow + 750) * 0.001, () -> {
    if (splash.animation != null) splash.animation.finishCallback();
    strum.strumLine.onHit.remove(callbackHit);
    strum.strumLine.onMiss.remove(callbackMiss);
  });

  if (isModchart) splash.shader = strum.shader;

  add(splash);

  while(splashHoldHandler.members.length > 16)
    remove(splashHoldHandler.members[0], true);
}

function stepCrochetUpdate()
	stepCrochet = Conductor.stepCrochet;

function destroy()
  Conductor.onBPMChange.remove(stepCrochetUpdate);