importScript('data/scripts/Particle');

var index:Int;
var indexDad:Int;

function postCreate() {
	index = members.indexOf(bfShadow);
	indexDad = members.indexOf(dad);

	newSnow([-800, -400], [1836, 0], [1836, 980], [20, 980], [0.5, 1.5], 0.01, [0, 400, 2, 8]);
}

public function setParticle(sprite) {
	sprite.color = 0xFF4A5568;
	sprite.scale.x *= 2;
	sprite.scale.y *= 2;
	if (sprite.scrollFactor.x > 0.95 && sprite.scrollFactor.x <= 1) insert(indexDad, sprite);
	if (sprite.scrollFactor.x <= 0.95) insert(index, sprite);
}