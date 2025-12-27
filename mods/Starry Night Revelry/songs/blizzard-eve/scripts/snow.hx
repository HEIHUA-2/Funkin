importScript('data/scripts/Particle');

var index:Int;
var indexDad:Int;

function postCreate() {
	index = members.indexOf(bfShadow);
	indexDad = members.indexOf(dad);

	newSnow([-800, -400], [1836, 0], [1836, 980], [20, 980], [0.5, 1.5], 0.1, [0, 400, 6, 10]);
}

public function setParticle(sprite) {
	sprite.color = 0xffe5e5e5;
	if (sprite.scrollFactor.x > 0.95 && sprite.scrollFactor.x <= 1) insert(indexDad, sprite);
	if (sprite.scrollFactor.x <= 0.95) insert(index, sprite);
}