// https://github.com/TheZoroForce240/CNE-GPU-Modchart-Framework

// https://github.com/openfl/openfl/blob/develop/src/openfl/geom/PerspectiveProjection.hx
var fov = 90 * (Math.PI/180);
var focalLength = 1.0 * (1.0 / Math.tan(fov * 0.5));

/////////////////////////////////

// 着色器缓存池
var shaderCacheVert:Array<String> = [];
var shaderCacheFrag:Array<String> = [];
var shaderPoolVert:Array<Array<Array<String>>> = [];
var shaderPoolFrag:Array<Array<Array<String>>> = [];

function createPerspectiveShader(obj, strumLineID, strumID)
{
	var vertCode = shaderPoolVert[strumLineID][strumID];
	var fragCode = shaderPoolFrag[strumLineID][strumID];

	var shaderIndex = -1;
	for (i in 0...shaderCacheVert.length) {
		if (shaderCacheVert[i] == vertCode && shaderCacheFrag[i] == fragCode) {
			shaderIndex = i;
			break;
		}
	}

	var shader;
	if (shaderIndex >= 0) {
		shader = new FunkinShader(shaderCacheFrag[shaderIndex], shaderCacheVert[shaderIndex]);
	} else {
		shader = new FunkinShader(fragCode, vertCode);
		shaderCacheVert.push(vertCode);
		shaderCacheFrag.push(fragCode);
	}
	
	shader.data.vertexID.value = [0, 1, 2, 3];
	shader.perspectiveMatrix = [
		focalLength, 0, 0, 0,
		0, focalLength, 0, 0,
		0, 0, 1.0, 1.0,
		0, 0, 0, 0
	];
	obj.shader = shader;
}

/////////////////////////////////////

public var modifiers:Array<Dynamic> = [];
//modtable that precalculates which mods are used for which strum note
public var modTable:Array<Dynamic> = [];

//indexing variables (used kinda like an enum)
public var MOD_NAME = 0;
public var MOD_VALUE = 1;
public var MOD_FUNC = 2;
public var MOD_DEFAULTVALUE = 3;
public var MOD_AUTODISABLE = 4;
public var MOD_ENABLED = 5;
public var MOD_STRUMLINEID = 6;
public var MOD_STRUMID = 7;
public var MOD_TYPE = 8;

public var MOD_TYPE_NOTE = 0; //updates for each note/strum
public var MOD_TYPE_CUSTOM = 1; //updates once per frame
public var MOD_TYPE_FRAG = 2;

public var modEvents:Array<Dynamic> = [];
public var EVENT_TIME = 0;
public var EVENT_TYPE = 1;
public var EVENT_MODNAME = 2;
public var EVENT_VALUE = 3;
public var EVENT_EASENAME = 4;
public var EVENT_EASETIME = 5;

public var EVENT_TYPE_EASE = 0;
public var EVENT_TYPE_SET = 1;


var initialized = false;

public var modchartManagerKeyCount:Int = 4;

var point:FlxPoint = new FlxPoint();
function postUpdate(elapsed)
{
	if (!initialized)
		return;

	//check events
	while(modEvents.length > 0 && modEvents[0][EVENT_TIME] <= Conductor.songPosition)
	{
		if (modEvents[0][EVENT_TYPE] == EVENT_TYPE_EASE)
		{
			var easeFunc = CoolUtil.flxeaseFromString(modEvents[0][EVENT_EASENAME], "");
			tweenModifierValue(modEvents[0][EVENT_MODNAME], modEvents[0][EVENT_VALUE], modEvents[0][EVENT_EASETIME] * Conductor.crochet * 0.001, easeFunc);
		}
		else if (modEvents[0][EVENT_TYPE] == EVENT_TYPE_SET)
		{
			setModifierValue(modEvents[0][EVENT_MODNAME], modEvents[0][EVENT_VALUE]);
		}

		modEvents.remove(modEvents[0]);
	}

	updateModifers();
}


function reconstructModTable()
{
	modTable = [];

	for(p in 0...PlayState.SONG.strumLines.length)
	{
		modTable.push([]);
		for (i in 0...modchartManagerKeyCount)
		{
			modTable[p].push([]);
			for (mod in modifiers)
			{
				if ((mod[MOD_STRUMLINEID] == -1 || mod[MOD_STRUMLINEID] == p) && (mod[MOD_STRUMID] == -1 || mod[MOD_STRUMID] == i))
				{
					modTable[p][i].push(mod); //add modifier to table so it knows which modifiers are gonna be used for each individual strum
				}
			}
		}
	}
}

function updateModifers()
{
	for (mod in modifiers)
	{
		if (mod[MOD_AUTODISABLE])
		{
			mod[MOD_ENABLED] = mod[MOD_VALUE] != mod[MOD_DEFAULTVALUE];				
		}

		if (mod[MOD_ENABLED] && mod[MOD_TYPE] == MOD_TYPE_CUSTOM)
		{
			mod[MOD_FUNC](mod); //call modifier function
		}
	}
}



public function initModchart()
{
	initialized = true;
	
	sortModEvents();
	reconstructModTable();
	generateShaderCode();

	function setupStrumShader(strum:Strum, lineID:Int, strumID:Int) {
		createPerspectiveShader(strum, lineID, strumID);
		strum.shader.isSustainNote = false;
		strum.shader.data.noteCurPos.value = [0.0, 0.0, 0.0, 0.0];
		strum.shader.scrollSpeed = 0.0;
		strum.shader.strumID = strumID;
		strum.shader.strumLineID = lineID;
	}

	function setupNoteShader(note:Note, lineID:Int, strumID:Int) {
		createPerspectiveShader(note, lineID, strumID);
		note.shader.strumID = strumID;
		note.shader.strumLineID = lineID;
	}

	function setupStrumDraw(strum:Strum, lineID:Int) {
		strum.onDraw = () -> {
			strum.shader.songPosition = Conductor.songPosition;
			strum.shader.curBeat = Conductor.curBeatFloat;
			strum.shader.frameUV = [strum.frame.uv.x, strum.frame.uv.y, strum.frame.uv.width, strum.frame.uv.height];
			strum.shader.posX = strum.x;
			strum.shader.posY = strum.y;

			strum.getScreenPosition(point, strum.camera);
			strum.shader.screenX = strum.x + strum.origin.x + point.x - strum.offset.x;
			strum.shader.screenY = strum.y + strum.origin.y + point.y - strum.offset.y;

			strum.shader.downscroll = downscroll;

			for (mod in modTable[lineID][strum.ID])
				Reflect.setProperty(Reflect.getProperty(strum.shader.data, mod[MOD_NAME] + '_value'), 'value', [mod[MOD_VALUE]]);

			strum.draw();
		}
	}

	function setupNoteDraw(note:Note, lineID:Int) {
		note.onDraw = () -> {
			if (note.shader == null) {
				note.drawComplex(note.camera);
				return;
			}

			note.shader.songPosition = Conductor.songPosition;
			note.shader.curBeat = Conductor.curBeatFloat;
			note.shader.downscroll = downscroll;
			note.shader.isSustainNote = note.isSustainNote;
			note.shader.frameUV = [note.frame.uv.x, note.frame.uv.y, note.frame.uv.width, note.frame.uv.height];

			var curPos = Conductor.songPosition - note.strumTime;
			var nextCurPos = curPos;

			if (note.isSustainNote) {
				if (note.nextNote != null && note.nextNote.isSustainNote) 
					nextCurPos = Conductor.songPosition - note.nextNote.strumTime;

				if (note.nextSustain == null)
					nextCurPos = Conductor.songPosition - (note.strumTime + (Conductor.stepCrochet * 0.5));

				if (note.wasGoodHit && curPos >= 0) 
					curPos = 0;
			}
			
			note.shader.data.noteCurPos.value = [curPos, curPos, nextCurPos, nextCurPos];
			note.shader.scrollSpeed = strumLines.members[lineID].members[note.strumID].getScrollSpeed(note);

			note.shader.posX = note.x;
			note.shader.posY = note.y;

			if (note.__strum != null) {
				note.getScreenPosition(point, note.camera);
				note.shader.screenX = (note.origin.x + point.x - note.offset.x) + note.__strum.x;
				note.shader.screenY = (note.origin.y + point.y - note.offset.y) + (downscroll ? -note.__strum.y : note.__strum.y);
				note.x = note.__strum.x;
				note.y = note.__strum.y;
			}

			note.drawComplex(note.camera);
		}
	}

	for(p in strumLines) {
		var lineID = p.ID;

		p.forEach(function(strum) {
			setupStrumShader(strum, lineID, strum.ID);
			setupStrumDraw(strum, lineID);
		});

		for (note in p.notes.members) {
			if (note == null) continue;
			setupNoteShader(note, lineID, note.strumID);
			setupNoteDraw(note, lineID);
		}
	}
}

public function generateShaderCode()
{
	var name = "notePerspective";
	var fragShaderPath = Paths.fragShader(name);
	var vertShaderPath = Paths.vertShader(name);
	var fragCode = Assets.exists(fragShaderPath) ? Assets.getText(fragShaderPath) : null;
	var vertCode = Assets.exists(vertShaderPath) ? Assets.getText(vertShaderPath) : null;

	var numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
	var operators = ["+", "-", "*", "/", "(", ")", "="];
	var warnings = "";
	for (mod in modifiers)
	{
		if (mod[MOD_TYPE] == MOD_TYPE_NOTE || mod[MOD_TYPE] == MOD_TYPE_FRAG)
		{
			var foundBadNumber = false;
			var searching = false;

			var data:String = mod[MOD_FUNC];
			for (i in 0...data.length) //loop through every character
			{
				if (operators.contains(data.charAt(i))) //if its an operator then there could be a number afterwards
				{
					searching = true;
				}

				var number = data.charAt(i);
					
				if (numbers.contains(data.charAt(i)) && searching) //there is a number so lets check
				{
					var bad = true;
					while(true)
					{
						i++; //check next number
						if (numbers.contains(data.charAt(i)) || data.charAt(i) == ".") //if its a number or . then continue
						{
							number += data.charAt(i);
							if (data.charAt(i) == ".")
							{
								bad = false; //if the number contains a . then its all good
							}
						}
						else //break if not a number or .
						{
							searching = false;
							break;
						}
					}

					if (bad) //add to warnings since its bad
					{
						warnings += "\nWARNING: found bad number '" + number + "' in Modifier '" + mod[MOD_NAME] + "'\nIf this is intentional then ignore, otherwise add .0!\n";
					}
				}
				else if (!operators.contains(data.charAt(i)) && data.charAt(i) != " ") //not a number or operator so reset, but ignore spaces
					searching = false;
			}
		}
	}

	if (warnings != "")
		trace(warnings);

	shaderPoolVert = [];
	shaderPoolFrag = [];
	
	for(p in 0...PlayState.SONG.strumLines.length)
	{
		shaderPoolVert[p] = [];
		shaderPoolFrag[p] = [];
		
		for (i in 0...modchartManagerKeyCount)
		{
			var vertCode = Assets.exists(Paths.vertShader("notePerspective")) ? 
				Assets.getText(Paths.vertShader("notePerspective")) : "";
				
			var fragCode = Assets.exists(Paths.fragShader("notePerspective")) ? 
				Assets.getText(Paths.fragShader("notePerspective")) : "";
			
			var modifierUniformsVertCode = "";
			var modifierFunctionsVertCode = "";
			var modifierUniformsFragCode = "";
			var modifierFunctionsFragCode = "";
			
			for (mod in modTable[p][i])
			{
				if (mod[MOD_TYPE] == MOD_TYPE_NOTE)
				{
					//declare uniform
					modifierUniformsVertCode += "uniform float " + mod[MOD_NAME] + "_value;\n";

					//add modifier code
					if (mod[MOD_AUTODISABLE])
					{
						var defaultValue = mod[MOD_DEFAULTVALUE];
						if (!StringTools.contains(defaultValue, "."))
							defaultValue += ".0"; //make sure it has a decimal so the shader knows its a float
			
						modifierFunctionsVertCode += "if (" + mod[MOD_NAME] + "_value != " + (defaultValue) + ")";
						modifierFunctionsVertCode += "{";
						modifierFunctionsVertCode += mod[MOD_FUNC];
						modifierFunctionsVertCode += "}";
					}
					else
					{
						modifierFunctionsVertCode += mod[MOD_FUNC];
					}
				}
				else if (mod[MOD_TYPE] == MOD_TYPE_FRAG)
				{
					//declare uniform
					modifierUniformsFragCode += "uniform float " + mod[MOD_NAME] + "_value;\n";

					//add modifier code
					if (mod[MOD_AUTODISABLE])
					{
						var defaultValue = mod[MOD_DEFAULTVALUE];
						if (!StringTools.contains(defaultValue, "."))
							defaultValue += ".0"; //make sure it has a decimal so the shader knows its a float
			
						modifierFunctionsFragCode += "if (" + mod[MOD_NAME] + "_value != " + (defaultValue) + ")";
						modifierFunctionsFragCode += "{";
						modifierFunctionsFragCode += mod[MOD_FUNC];
						modifierFunctionsFragCode += "}";
					}
					else
					{
						modifierFunctionsFragCode += mod[MOD_FUNC];
					}
				}
			}

			vertCode = StringTools.replace(vertCode, "#pragma modifierUniforms", modifierUniformsVertCode);
			vertCode = StringTools.replace(vertCode, "#pragma modifierFunctions", modifierFunctionsVertCode);
			fragCode = StringTools.replace(fragCode, "#pragma modifierUniforms", modifierUniformsFragCode);
			fragCode = StringTools.replace(fragCode, "#pragma modifierFunctions", modifierFunctionsFragCode);

			shaderPoolVert[p][i] = vertCode;
			shaderPoolFrag[p][i] = fragCode;
		}
	}
}

////Modifier Functions/////
public function createModifier(name:String, value:Float, func:Dynamic, strumLineID:Int = -1, strumID = -1, defaultValue:Float = 0.0, autoDisable = true, modType:Int = 0)
{
	if (defaultValue == null)
		defaultValue = 0.0;
	if (autoDisable == null)
		autoDisable = true;
	if (strumLineID == null)
		strumLineID = -1;
	if (strumID == null)
		strumID = -1;
	if (modType == null)
		modType = MOD_TYPE_NOTE;

	var modData = [name, value, func, defaultValue, autoDisable, true, strumLineID, strumID, modType];
	modifiers.push(modData);

	reconstructModTable();
}

public function tweenModifierValue(name:String, newValue:Float, time:Float, easeFunc:Float->Float)
{
	var mod = null;
	for (m in modifiers)
		if (m[MOD_NAME] == name)
			mod = m;

	if (mod == null)
		return; //cant find

	var startValue = mod[MOD_VALUE];
	FlxTween.num(startValue, newValue, time, {ease: easeFunc}, (val:Float) -> {
		mod[MOD_VALUE] = val;
	});
}

public function setModifierValue(name:String, newValue:Float)
{
	var mod = null;
	for (m in modifiers)
		if (m[MOD_NAME] == name)
			mod = m;

	if (mod == null)
		return; //cant find

	mod[MOD_VALUE] = newValue;
}

public function ease(beat:Float, timeInBeats:Float, easeName:String, data:String)
{
	var arguments = StringTools.replace(StringTools.trim(data), ' ', '').split(',');

	var time = Conductor.getTimeForStep(beat*4);

	for (i in 0...Math.floor(arguments.length/2))
	{
		var name:String = Std.string(arguments[1 + (i*2)]);
		var value:Float = Std.parseFloat(arguments[0 + (i*2)]);
		if(Math.isNaN(value))
			value = 0;

		modEvents.push([time, EVENT_TYPE_EASE, name, value, easeName, timeInBeats]);
	}
}

public function set(beat:Float, data:String)
{
	var arguments = StringTools.replace(StringTools.trim(data), ' ', '').split(',');

	var time = Conductor.getTimeForStep(beat*4);

	for (i in 0...Math.floor(arguments.length/2))
	{
		var name:String = Std.string(arguments[1 + (i*2)]);
		var value:Float = Std.parseFloat(arguments[0 + (i*2)]);
		if(Math.isNaN(value))
			value = 0;

		modEvents.push([time, EVENT_TYPE_SET, name, value]);
	}
}

public function sortModEvents()
{
	modEvents.sort(function(a, b) {
		if(a[EVENT_TIME] < b[EVENT_TIME]) return -1;
		else if(a[EVENT_TIME] > b[EVENT_TIME]) return 1;
		else return 0;
	 });
}

@:bypassAccessor
public function addModifier(mod)
{
	var value = mod + '_value';
	switch (mod)
	{
		case 'x':
			createModifier(mod, 0, '
				x -= ' + value + ';
			');
		case 'y':
			createModifier(mod, 0, '
				y -= ' + value + ';
			');
		case 'z':
			createModifier(mod, 0, '
				z -= ' + value + ';
			');
		case 'angleX':
			createModifier(mod, 0, '
				angleX += ' + value + ';
			');
		case 'angleY':
			createModifier(mod, 0, '
				angleY += ' + value + ';
			');
		case 'angleZ':
			createModifier(mod, 0, '
				angleZ += ' + value + ';
			');
		case 'scaleX':
			createModifier(mod, 1, '
				scaleX *= ' + value + ';
			');
		case 'scaleY':
			createModifier(mod, 1, '
				scaleY *= ' + value + ';
			');
		case 'skewX':
			createModifier(mod, 0, '
				if (!isSustainNote)
				{
					float skewAmount = tan(' + value + ' * RAD_PER_DEG);
					if (vertexID == 0.0 || vertexID == 1.0)
					{
						x += skewAmount;
					}
					if (vertexID == 2.0 || vertexID == 3.0)
					{
						x -= skewAmount;
					}
				}
			');
		case 'skewY':
			createModifier(mod, 0, '
				if (!isSustainNote)
				{
					float skewAmount = tan(' + value + ' * RAD_PER_DEG);
					if (vertexID == 0.0 || vertexID == 2.0)
					{
						y += skewAmount;
					}
					if (vertexID == 1.0 || vertexID == 3.0)
					{
						y -= skewAmount;
					}
				}
			');
		case 'incomingAngleX':
			createModifier(mod, 0, 'incomingAngleX += ' + value + ';');
		case 'incomingAngleY':
			createModifier(mod, 0, 'incomingAngleY += ' + value + ';');
		case 'incomingAngleZ':
			createModifier(mod, 0, 'incomingAngleZ += ' + value + ';');
		case 'flip':
			createModifier(mod, 0, '
				float newPos = 4.0 + (strumID - 0.0) * ((-4.0 - 4.0) / (4.0 - 0.0));
				x += (112.0 * newPos * ' + value + ') - (112.0 * ' + value + ');
			');
		case 'speed':
			createModifier(mod, 0, '
				curPos *= ' + value + ';
			');
		case 'schmovinArrowShape':
			createModifier('schmovinArrowShapeOffset', 0.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float pathProgress = curPos / 1500.0;
				float pathX = 640.0 + sin(pathProgress * PI * 2.0) * 200.0;
				float pathY = 360.0 + cos(pathProgress * PI * 2.0) * 200.0;
				float pathZ = strumID * schmovinArrowShapeOffset_value;
				x += (pathX - posX) * ' + value + ';
				y += (pathY - posY) * ' + value + ';
				z += pathZ * ' + value + ';
			');
		case 'spiral':
			createModifier('spiralDist', 1.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float centerX = 640.0;
				float centerY = 360.0;
				float radiusOffset = -curPos * 0.25;
				float crochet = songPosition / curBeat;
				float radius = radiusOffset + spiralDist_value * strumID;
				float spiralX = centerX + cos(-curPos / crochet * PI + curBeat * (PI * 0.25)) * radius;
				float spiralY = centerY + sin(-curPos / crochet * PI - curBeat * (PI * 0.25)) * radius;
				float spiralZ = radius / (centerY * 4.0);
				x += (spiralX - posX) * ' + value + ';
				y += (spiralY - posY) * ' + value + ';
				z += spiralZ * ' + value + ';
			');
		case 'vibrate':
			createModifier(mod, 0, '
				float randomX = hash(songPosition * 0.001 + strumID * 10.0) * 2.0 - 1.0;
				float randomY = hash(songPosition * 0.001 + strumID * 10.0 + 100.0) * 2.0 - 1.0;
				x += randomX * ' + value + ' * 20.0;
				y += randomY * ' + value + ' * 20.0;
			');
		case 'wiggle':
			createModifier('rotateZ', 0.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float wiggleX = sin(curBeat) * ' + value + ' * 20.0;
				float wiggleY = sin(curBeat + 1.0) * ' + value + ' * 20.0;
				x += wiggleX;
				y += wiggleY;
				angleZ += sin(curBeat) * 0.2 * ' + value + ' * 57.2958;
			');
		case 'counterClockWise':
			createModifier(mod, 0, '
				float strumTime = songPosition + curPos;
				float centerX = 640.0;
				float centerY = 360.0;
				float radiusOffset = 112.0 * (strumID - 3.0);
				float crochet = songPosition / curBeat;
				float radius = 200.0 + radiusOffset * cos(strumTime / crochet * 0.25 / 16.0 * PI);
				float ccwX = centerX + (cos(strumTime / crochet / 4.0 * PI) - PI * 0.25) * radius;
				float ccwY = centerY + (sin(strumTime / crochet / 4.0 * PI) - PI * 0.25) * radius;
				x += (ccwX - posX) * ' + value + ';
				y -= (ccwY - posY) * ' + value + ';
			');
		case 'eyeShape':
			createModifier(mod, 0, '
				float pathProgress = curPos / 2000.0;
				float angle = pathProgress * PI * 4.0;
				float eyeX = 640.0 - 264.0 - 272.0 + cos(angle) * 300.0 * (1.0 + sin(angle) * 0.3);
				float eyeY = 360.0 + 280.0 - 260.0 + sin(angle) * 200.0 * (1.0 + cos(angle) * 0.3);
				x += (eyeX - posX) * ' + value + ';
				y += (eyeY - posY) * ' + value + ';
			');
		case 'infinite':
			createModifier(mod, 0, '
				float rat = mod(strumID, 2.0) == 0.0 ? 1.0 : -1.0;
				float fTime = (-curPos * 0.001) + rat * (PI * 0.5);
				float invTransf = (2.0 / (3.0 - cos(fTime * 2.0)));
				float infiniteX = 640.0 + invTransf * cos(fTime) * 290.0;
				float infiniteY = 360.0 + invTransf * (sin(fTime * 2.0) * 0.5) * 375.0;
				x += (infiniteX - posX) * ' + value + ';
				y += (infiniteY - posY) * ' + value + ';
			');
		case 'beat':
			createModifier('beatSpeed', 1.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float fAccelTime = 0.2;
				float fTotalTime = 0.5;
				float fBeat = curBeat + fAccelTime;
				fBeat *= beatSpeed_value;

				if (fBeat >= 0.0) {
					float evenBeat = mod(floor(fBeat), 2.0);
					fBeat = fract(fBeat + 1.0);

					if (fBeat < fTotalTime) {
						float fAmount = 0.0;
						if (fBeat < fAccelTime) {
							fAmount = fBeat * (1.0 / fAccelTime);
							fAmount *= fAmount;
						} else {
							fAmount = 1.0 + (fBeat - fAccelTime) * (-1.0 / (fTotalTime - fAccelTime));
							fAmount = 1.0 - (1.0 - fAmount) * (1.0 - fAmount);
						}

						if (evenBeat != 0.0) fAmount *= -1.0;
						x += 20.0 * fAmount * sin((curPos * 0.01) + (PI * 0.5)) * ' + value + ';
					}
				}
			');
		case 'reverse':
			createModifier(mod, 0, '
				float reversePerc = ' + value + ';
				if (downscroll) reversePerc = 1.0 - reversePerc;
				float initialY = 50.0 + 56.0;
				float shift = initialY * (1.0 - reversePerc) + (720.0 - initialY) * reversePerc;
				float scroll = curPos * (1.0 - reversePerc * 2.0);
				y = shift + (downscroll ? -scroll : scroll);
			');
		case 'radionic':
			createModifier(mod, 0, '
				float angle = ((1.0 / 0.45) * ((songPosition + curPos) * PI * 0.25) + (PI * strumLineID));
				float receptorX = 112.0 * (strumID - 3.0) + 640.0;
				float offsetX = posX - receptorX;
				float offsetY = posY - 50.0;
				float circf = 112.0 + strumID * 112.0;
				float sinAng = sin(angle);
				float cosAng = cos(angle);
				float radX = 640.0 + ((sinAng * offsetY + cosAng * (circf + offsetX)) * 0.7) * 1.125;
				float radY = 360.0 + ((cosAng * offsetY + sinAng * (circf + offsetX)) * 0.7) * 0.875;
				x += (radX - posX) * ' + value + ';
				y += (radY - posY) * ' + value + ';
			');
		case 'stealthFrag':
			createModifier(mod, 0, '
				float visibility = 1.0 - ' + value + ';
				color.a *= visibility;
			', -1, -1, 0.0, true, MOD_TYPE_FRAG);
		case 'confusion':
			createModifier(mod, 0, '
				float angle = -(curBeat * ' + value + ') + (curPos * 0.1);
				angleZ += angle;
			');
		case 'bounce':
			createModifier('bounceSpeed', 1.0, '', -1, -1, 0.0, false);
			createModifier('bounceOffset', 0.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float bounce = abs(sin((curBeat + bounceOffset_value) * (1.0 + bounceSpeed_value) * PI)) * 112.0;
				y += bounce * ' + value + ';
			');
		case 'bumpy':
			createModifier('bumpyOffset', 0.0, '', -1, -1, 0.0, false);
			createModifier('bumpyPeriod', 1.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float bumpy = 40.0 * sin(curPos + (100.0 * bumpyOffset_value)) / ((bumpyPeriod_value * 24.0) + 24.0);
				y += bumpy * ' + value + ';
			');
		case 'drunk':
			createModifier('drunkSpeed', 1.0, '', -1, -1, 0.0, false);
			createModifier('drunkPeriod', 1.0, '', -1, -1, 0.0, false);
			createModifier('drunkOffset', 0.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float shift = songPosition * 0.001 * (1.0 + drunkSpeed_value) + strumID * (0.2 + (drunkOffset_value * 0.2)) + curPos * ((drunkPeriod_value * 10.0) + 10.0) / 720.0;
				float drunk = cos(shift) * 112.0 * 0.5;
				x += drunk * ' + value + ';
			');
		case 'invert':
			createModifier('flip', 1.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float invert = -(mod(strumID, 2.0) - 0.5) * 2.0;
				float flip = (strumID - 1.5) * -2.0;
				x += 112.0 * (invert * ' + value + ' + flip * flip_value);
			');
		case 'rotate':
			createModifier(mod, 0, '
				float originX = 640.0;
				float originY = 360.0;
				float relX = posX - originX;
				float relY = posY - originY;
				float angle = ' + value + ' * RAD_PER_DEG;
				float cosA = cos(angle);
				float sinA = sin(angle);
				x = originX + (relX * cosA - relY * sinA);
				y = originY + (relX * sinA + relY * cosA);
			');
		case 'opponentSwap':
			createModifier(mod, 0, '
				float distX = 640.0;
				if (strumLineID == 0.0) {
					x -= distX * ' + value + ';
				} else {
					x += distX * ' + value + ';
				}
			');
		case 'receptorScroll':
			createModifier(mod, 0, '
				float moveSpeed = 360.0 * 4.0;
				float diff = -curPos;
				float vDiff = -(diff - songPosition) / moveSpeed;
				bool reversed = mod(floor(vDiff), 2.0) == 0.0;
				float revPerc = reversed ? 1.0 - fract(vDiff) : fract(vDiff);
				float upscrollOffset = 50.0;
				float downscrollOffset = 720.0 - 150.0;
				float endY = upscrollOffset + ((downscrollOffset - 56.0) * revPerc) + 56.0;
				y += (endY - posY) * ' + value + ';
			');
		case 'sawtooth':
			createModifier('sawtoothPeriod', 1.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float period = 1.0 + sawtoothPeriod_value;
				float saw = (0.5 / period * curPos) / 112.0 - floor((0.5 / period * curPos) / 112.0);
				x += saw * 112.0 * ' + value + ';
			');
		case 'schmovinDrunk':
			createModifier(mod, 0, '
				float phaseShift = strumID * 0.5 + (curPos * (1.0 / 222.0)) * PI;
				x += sin(curBeat * 0.25 * PI + phaseShift) * 56.0 * ' + value + ';
			');
		case 'stealth':
			createModifier(mod, 0, '
				// 在片段着色器中处理alpha
			', -1, -1, 0.0, true, MOD_TYPE_FRAG);
		case 'tornado':
			createModifier(mod, 0, '
				float keyCount = 4.0;
				bool bWideField = keyCount > 4.0;
				float iTornadoWidth = bWideField ? 4.0 : 3.0;
				float iStartCol = strumID - iTornadoWidth;
				float iEndCol = strumID + iTornadoWidth;
				iStartCol = clamp(iStartCol, 0.0, keyCount);
				iEndCol = clamp(iEndCol, 0.0, keyCount);
				float fXOffset = (168.0 - (112.0 * strumID));
				float fMinX = -fXOffset;
				float fMaxX = fXOffset;
				float fPositionBetween = (fXOffset - fMinX) * (1.0 - (-1.0)) / (fMaxX - fMinX) + (-1.0);
				float fRads = acos(fPositionBetween);
				fRads += (curPos * 0.8) * 6.0 / 720.0;
				float fAdjustedPixelOffset = (cos(fRads) - (-1.0)) * (fMaxX - fMinX) / (1.0 - (-1.0)) + fMinX;
				x -= (fAdjustedPixelOffset - fXOffset) * ' + value + ';
			');
		case 'scale':
			createModifier(mod, 1.0, '
				scaleX *= ' + value + ';
				scaleY *= ' + value + ';
			');
		case 'boost':
			createModifier('boostScale', 1.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float scale = 720.0 * boostScale_value;
				float shift = curPos * 1.5 / ((curPos + (scale) / 1.2) / scale);
				y += clamp(' + value + ' * (shift - curPos), -600.0, 600.0);
			');
		case 'brake':
			createModifier('brakeScale', 1.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float scale = 720.0 * brakeScale_value;
				float fScale = 0.0 + (-curPos - 0.0) * ((1.0 - 0.0) / (scale - 0.0));
				float fNewYOffset = -curPos * fScale;
				float fBrakeYAdjust = ' + value + ' * (fNewYOffset - (-curPos));
				fBrakeYAdjust = clamp(fBrakeYAdjust, -400.0, 400.0);
				curPos += fBrakeYAdjust;
			');
		case 'wave':
			createModifier('waveMult', 1.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				y += (-' + value + ' * 100.0) * sin(curPos * (1.0 / 38.0) * waveMult_value * 0.2);
			');
		case 'schmovinTipsy':
			createModifier(mod, 0, '
				y += sin(curBeat / 4.0 * PI + strumID) * 56.0 * ' + value + ';
			');
		case 'tipsy':
			createModifier('tipsySpeed', 1.0, '', -1, -1, 0.0, false);
			createModifier('tipsyOffset', 0.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float tipsy = cos(songPosition * 0.001 * ((tipsySpeed_value * 1.2) + 1.2) + strumID * ((tipsyOffset_value * 1.8) + 1.8)) * 112.0 * 0.4;
				y += tipsy * ' + value + ';
			');
		case 'zigZag':
			createModifier(mod, 0, '
				float theta = -curPos / 112.0 * PI;
				float outRelative = acos(cos(theta + PI * 0.5)) / PI * 2.0 - 1.0;
				x += outRelative * 56.0 * ' + value + ';
			');
		case 'schmovinTornado':
			createModifier(mod, 0, '
				float columnShift = strumID * PI / 3.0;
				float strumNegator = (-cos(-columnShift) + 1.0) * 0.5 * 112.0 * 3.0;
				float tornadoX = ((-cos((curPos / 135.0) - columnShift) + 1.0) * 0.5 * 112.0 * 3.0 - strumNegator);
				x += tornadoX * ' + value + ';
			');
		case 'square':
			createModifier('squareOffset', 0.0, '', -1, -1, 0.0, false);
			createModifier('squarePeriod', 1.0, '', -1, -1, 0.0, false);
			createModifier(mod, 0, '
				float amp = (PI * (curPos + squareOffset_value) / (112.0 + (squarePeriod_value * 112.0)));
				float fAngle = mod(amp, PI * 2.0);
				float square = fAngle >= PI ? -1.0 : 1.0;
				x += square * ' + value + ';
			');
		case 'drugged':
			createModifier(mod, 0, '
				float xCoord = (curPos * 0.009) + (strumID * 0.125);
				float t = 0.01 * (-songPosition * 0.0025 * 130.0);
				float yDrugged = sin(xCoord);
				yDrugged += sin(xCoord * 2.1 + t) * 4.5;
				yDrugged += sin(xCoord * 1.72 + t * 1.121) * 4.0;
				yDrugged += sin(xCoord * 2.221 + t * 0.437) * 5.0;
				yDrugged += sin(xCoord * 3.1122 + t * 4.269) * 2.5;
				yDrugged *= 0.06;
				x += yDrugged * ' + value + ' * 112.0 * 0.8;
			');
	}
}


//fixes for splashes
@:bypassAccessor
function onNoteHit(event)
{
	if (event.showSplash)
	{
		event.showSplash = false;

		if (event.note.__strum == null) return;
		
		//show splash func (but we need to keep the splash sprite for after)
		splashHandler.__grp = splashHandler.getSplashGroup(event.note.splash);
		var splash = splashHandler.__grp.showOnStrum(event.note.__strum);
		splash.shader = event.note.__strum.shader;
		splashHandler.add(splash);
		// max 8 rendered splashes
		while(splashHandler.members.length > 8) {
				var old = splashHandler.members[0];
				splashHandler.remove(old, true);
				old.destroy();
		}
	}
}