function postUpdate(elapsed)
{
  var limit = 248 + 112 / (1 / camHUD.zoom) + 720 / scrollSpeed / camHUD.zoom + Conductor.stepCrochet;
	for(strumLine in strumLines)
  strumLine.notes.limit = limit;
}