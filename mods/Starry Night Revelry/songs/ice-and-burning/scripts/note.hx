var cpuX = [];
var cpuY = [];
var cpuA = [];
static var noteOffset = 2;
static var noteOffsetAngle = 1;

function postCreate() {
  for (i in 0...4) {
    cpuX[i] = cpu.members[i].x;
    cpuY[i] = cpu.members[i].y;
    cpuA[i] = cpu.members[i].angle;
  }
}

// var t = 0;
// function postUpdate(elapsed)
// {
//   t += elapsed;
//   if (t >= 1 / 30)
//   {
//     t -= 1 / 30;
//     for (i in 0...4)
//     {
//       cpu.members[i].x = cpuX[i] + FlxG.random.float(-noteOffset, noteOffset);
//       cpu.members[i].y = cpuY[i] + FlxG.random.float(-noteOffset, noteOffset);
//       cpu.members[i].angle = cpuA[i] + FlxG.random.float(-noteOffsetAngle, noteOffsetAngle);
//     }
//   }
// }