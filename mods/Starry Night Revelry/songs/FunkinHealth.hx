static var dadHitHealth = 0;
static var dadHitHealthSus = 0;
static var dadHitHealthMix = 2;

static var hitStep = 0;
static var stepHealth = 0;
static var stepHealthMix = 0;

function create() {
	dadHitHealth = 0;
	dadHitHealthSus = 0;
	dadHitHealthMix = 2;
}


function onDadHit(event) {
	var hitHealth = !event.note.isSustainNote ? dadHitHealth : dadHitHealthSus;
	if (health - hitHealth > dadHitHealthMix) {
		health -= hitHealth;
	} else if (health > dadHitHealthMix) {
		health = dadHitHealthMix;
	}
}


public function setDadHitHealth(n:Float, s:Float, m:Float) {
	if (n != null) dadHitHealth = n;
	if (s != null) dadHitHealthSus = s;
	if (m != null) dadHitHealthMix = m;
}


function stepHit(step) {
	if (step % hitStep == 0) {
		var hitHealth = stepHealth;
		if (health - stepHealth > stepHealthMix) {
			health -= stepHealth;
		} else if (health > stepHealthMix) {
			health = stepHealthMix;
		}
	}
}
// 扣鞋