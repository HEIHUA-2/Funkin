#pragma header

const float PI = 3.14159265359;

attribute float alpha;
attribute vec4 colorMultiplier;
attribute vec4 colorOffset;
uniform bool hasColorTransform;

uniform bool downscroll;
uniform bool isSustainNote;

uniform mat4 perspectiveMatrix;

uniform float posX;
uniform float posY;

uniform float screenX;
uniform float screenY;

uniform float songPosition;
uniform float curBeat;
uniform float scrollSpeed;

uniform float strumID;
uniform float strumLineID;
attribute float noteCurPos;
attribute float vertexID;

uniform vec4 frameUV;

#pragma modifierUniforms

mat4 computeViewMatrix(vec3 eye, vec3 lookAt, vec3 up) {
	vec3 forward = normalize(lookAt - eye);
	vec3 right = normalize(cross(up, forward));
	vec3 upv = normalize(cross(forward, right));
	
	vec3 negEye = -eye;
	
	return mat4(
		right.x, upv.x, forward.x, 0.0,
		right.y, upv.y, forward.y, 0.0,
		right.z, upv.z, forward.z, 0.0,
		dot(right, negEye), dot(upv, negEye), dot(forward, negEye), 1.0
	);
}

vec3 normalizeVec3(vec3 v) {
	float mag = sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
	return v / mag;
}

vec3 crossVec3(vec3 a, vec3 b) {
	return vec3(
		a.y * b.z - a.z * b.y,
		a.z * b.x - a.x * b.z,
		a.x * b.y - a.y * b.x
	);
}

float dotVec3(vec3 a, vec3 b) {
  return a.x*b.x + a.y*b.y + a.z*b.z;
}

float calculatePercentage(float number, float minValue, float maxValue) {
  return (number - minValue) / (maxValue - minValue);
}

mat4 rotation3d(vec3 axis, float angle) {
	axis = normalize(axis);
	float s = sin(angle);
	float c = cos(angle);
	float oc = 1.0 - c;
	
	return mat4(
		oc * axis.x * axis.x + c,		  oc * axis.x * axis.y - axis.z * s, oc * axis.z * axis.x + axis.y * s, 0.0,
		oc * axis.x * axis.y + axis.z * s, oc * axis.y * axis.y + c,		  oc * axis.y * axis.z - axis.x * s, 0.0,
		oc * axis.z * axis.x - axis.y * s, oc * axis.y * axis.z + axis.x * s, oc * axis.z * axis.z + c,		  0.0,
		0.0, 0.0, 0.0, 1.0
	);
}

float hash(float v) {
	return fract(sin(v * 12.9898) * 43758.5453) - 0.5;
}

void main(void) {
	const float RAD_PER_DEG = PI / 180.0;
	float curPos = noteCurPos;
	float scrollFactor = curPos * 0.45 * scrollSpeed;
	
	float x = 0.0;
	float y = 0.0;
	float z = 0.0;
	float a = 1.0; // alpha
	float angleX = 0.0;
	float angleY = 0.0;
	float angleZ = 0.0;
	float scaleX = 1.0;
	float scaleY = 1.0;
	float incomingAngleX = 0.0;
	float incomingAngleY = 0.0;
	float incomingAngleZ = 0.0;

	vec3 uEyePosition = vec3(0.0, 0.0, -1.0);
	vec3 uLookAt = vec3(0.0, 0.0, 0.0);
	vec3 uUp = vec3(0.0, 1.0, 0.0);

	#pragma modifierFunctions

	y -= scrollFactor; // undo regular speed

	if (incomingAngleX != 0.0 || incomingAngleY != 0.0 || incomingAngleZ != 0.0) {
		mat4 rotation = 
			rotation3d(vec3(1.0, 0.0, 0.0), incomingAngleX * RAD_PER_DEG) *
			rotation3d(vec3(0.0, 1.0, 0.0), incomingAngleY * RAD_PER_DEG) *
			rotation3d(vec3(0.0, 0.0, 1.0), incomingAngleZ * RAD_PER_DEG);
		
		vec4 p = rotation * vec4(0.0, scrollFactor, 0.0, 1.0);
		x += p.x;
		y += p.y;
		z += p.z;
	} else {
		y += scrollFactor; // reapply if no rotation
	}

	openfl_Alphav = openfl_Alpha * alpha * a;
	openfl_TextureCoordv = openfl_TextureCoord;
	
	if (hasColorTransform) {
		openfl_ColorOffsetv = colorOffset / 255.0;
		openfl_ColorMultiplierv = colorMultiplier;
	}

	vec4 pos = openfl_Position;
	pos.x -= screenX;
	pos.y -= screenY;

	if (!isSustainNote) {
		vec4 p = vec4(pos.x * scaleX, pos.y * scaleY, 0.0, 1.0);
		
		mat4 noteRotation = 
			rotation3d(vec3(1.0, 0.0, 0.0), angleX * RAD_PER_DEG) *
			rotation3d(vec3(0.0, 1.0, 0.0), angleY * RAD_PER_DEG) *
			rotation3d(vec3(0.0, 0.0, 1.0), angleZ * RAD_PER_DEG);

		p = noteRotation * p;
		pos.x = p.x;
		pos.y = p.y;
		z += p.z;
	} else {
		vec4 p = vec4(pos.x * scaleX, pos.y, 0.0, 1.0);

		mat4 noteRotation = 
			rotation3d(vec3(1.0, 0.0, 0.0), angleX * RAD_PER_DEG) *
			rotation3d(vec3(0.0, 1.0, 0.0), angleY * RAD_PER_DEG) *
			rotation3d(vec3(0.0, 0.0, 1.0), angleZ * RAD_PER_DEG);

		p = noteRotation * p;
		pos.x = p.x;
		pos.y = p.y;
		z += p.z;
	}

	pos.x += screenX + x;
	pos.y += screenY;
	pos.y += downscroll ? y : -y;

	pos = openfl_Matrix * pos;
	pos.z = z * 0.0015;

	mat4 viewMatrix = computeViewMatrix(uEyePosition, uLookAt, uUp);
	
	gl_Position = perspectiveMatrix * viewMatrix * pos;
}	