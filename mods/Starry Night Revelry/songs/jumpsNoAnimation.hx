var noteTime = -1;
var noteType = '';


function onPlayerHit(event)
{
  if (!event.note.isSustainNote && noteType == event.noteType && noteTime == event.note.strumTime)
    event.animCancelled = true;

  if (!event.note.isSustainNote)
  {
    noteTime = event.note.strumTime;
    noteType = event.noteType;
  }
}