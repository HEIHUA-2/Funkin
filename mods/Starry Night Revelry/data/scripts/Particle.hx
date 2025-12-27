static var particleSettings = {
    alpha: 1.0,
    color: 0xffffffff,
    mod: null
};

static var particle:Array<FunkinSprite> = [];
var snowPool:Array<FunkinSprite> = [];
var particle_x:Float;
var particle_y:Float;
var particle_width:Float;
var particle_height:Float;
var particle_tween:Array<Float>;
var particle_depth:Array<Float>;
var particle_frequency:Float;
var particle_speed:Array<Float>;
var particle_time:Float = 0;

function new() {
    particleSettings = {
        alpha: 1.0,
        color: 0xffffffff,
        mod: null
    };
    particle = [];
}

function getSnowSprite():FunkinSprite {
    if (snowPool.length > 0) {
        var sprite = snowPool.pop();
        sprite.revive();
        sprite.alpha = 1;
        return sprite;
    }
    return new FunkinSprite(0, 0, Paths.image('stages/particle'));
}

function recycleSnow(snowSprite:FunkinSprite) {
    FlxTween.cancelTweensOf(snowSprite);
    snowSprite.kill();
    snowPool.push(snowSprite);
    particle.remove(snowSprite);
}

public function newSnow(
    snowXY:Array<Float>, 
    snowWidthHeight:Array<Float>, 
    snowWidthHeight_2:Array<Float>, 
    tween:Array<Float>, 
    snowDepth:Array<Float>, 
    frequency:Float, 
    speed:Array<Float>
) {
    particle_x = snowXY[0];
    particle_y = snowXY[1];
    particle_width = snowWidthHeight[0];
    particle_height = snowWidthHeight[1];
    particle_tween = tween;
    particle_depth = snowDepth;
    particle_frequency = frequency;
    particle_speed = speed;

    // var random = speed[2] / frequency;
    // for (i in 0...Std.int(random)) {
    //     createSnow();
    // }
}

public function createSnow() {
    if (particleSettings.mod == 'close') return;

    var randoDepth = WRand(particle_depth[0], particle_depth[1], 0.5);
    var snowX = FlxG.random.float(particle_x, particle_width);
    var snowY = FlxG.random.float(particle_y, particle_height);
    var snowSpeedY = FlxG.random.float(particle_speed[2], particle_speed[3]);

    var snowSprite = getSnowSprite();
    snowSprite.setPosition(snowX, snowY);
    snowSprite.scale.set(randoDepth, randoDepth);
    snowSprite.antialiasing = Options.antialiasing;
    snowSprite.scrollFactor.set(randoDepth, randoDepth);

    var tweenTime = snowSpeedY / randoDepth;
	FlxTween.tween(snowSprite, 
        {
            x: snowSprite.x + FlxG.random.float(-particle_speed[0], particle_speed[1]),
            y: snowSprite.y + particle_tween[1]
        }, 
        tweenTime,
        {
            onComplete: function(_) {
                FlxTween.tween(snowSprite, {alpha: 0}, snowSpeedY, {
                    onComplete: function(_) {
                        recycleSnow(snowSprite);
                    }
                });
            }
        }
    );

    setParticle(snowSprite);
    add(snowSprite);
    particle.push(snowSprite);
}

function postUpdate(elapsed:Float) {
    particle_time += elapsed;
    if (particle_frequency != null && particle_time > 0) {
        var count = Math.min(Std.int(particle_time / particle_frequency), 10);
        particle_time -= count * particle_frequency;
        
        for (i in 0...count) {
            createSnow();
        }
    }
    // trace(particle.length);
}