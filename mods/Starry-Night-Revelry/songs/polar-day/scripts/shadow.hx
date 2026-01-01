public var licanisShadow:FunkinSprite;
public var licanisShadowAlpha = 1;
public var shadow_optimization_licanis:CustomShader;

function postCreate() {
  gf.scrollFactor.set(1, 1);

	bfShadowAlpha = 1;
	dadShadowAlpha = 1;

  dad.x -= 50;
  dad.y += 50;

  gf.x += 125;
  gf.y -= 50;

	licanisShadow = FunkinSprite.copyFrom(gf);
	licanisShadow.flipX = gf.flipX;
	licanisShadow.flipY = !gf.flipY;
	licanisShadow.color = 0x00000000;
	insert(members.indexOf(gf), licanisShadow);
	licanisShadow.skew.x = 10000 / gf.height;

	shadow_optimization_licanis = new CustomShader('polar-day/shadow_optimization_no_alpha');
	shadow_optimization_licanis.offsetY = -30;
	shadow_optimization_licanis.QUALITY = 8;
  shadow_optimization_licanis.color = [232 / 255 * 0.7, 228 / 255 * 0.7, 255 / 255 * 0.7];
	licanisShadow.shader = shadow_optimization_licanis;

	shadow_optimization_dad = new CustomShader('polar-day/shadow_optimization_no_alpha');
	shadow_optimization_dad.offsetY = -30;
	shadow_optimization_dad.QUALITY = 8;
  shadow_optimization_dad.color = [232 / 255 * 0.7, 228 / 255 * 0.7, 255 / 255 * 0.7];
	dadShadow.shader = shadow_optimization_dad;

	shadow_optimization_bf = new CustomShader('polar-day/shadow_optimization_no_alpha');
	shadow_optimization_bf.offsetY = -45;
	shadow_optimization_bf.QUALITY = 15;
  shadow_optimization_bf.color = [232 / 255 * 0.7, 228 / 255 * 0.7, 255 / 255 * 0.7];
	bfShadow.shader = shadow_optimization_bf;

  bfShadowAlpha = 1;
  dadShadowAlpha = 1;
}

function postUpdate(elapsed:Float) {
	licanisShadow.alpha = gf.alpha * licanisShadowAlpha;
	licanisShadow.setPosition(gf.x - 21, gf.y - 40);
	licanisShadow.frameOffset.set(gf.frameOffset.x, gf.frameHeight - gf.frameOffset.y - 825);
	licanisShadow.offset = gf.offset;
	licanisShadow.animation.frameName = gf.animation.frameName;
}