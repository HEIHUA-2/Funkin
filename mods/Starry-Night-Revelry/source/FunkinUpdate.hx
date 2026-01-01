// HeiHua

public var FunkinUpdate = {
	_update: [],
	_update_post: [],

	register: function(callback:Float->Dynamic, ?frameInterval:Float = 1000, ?onStart:Bool = true) {
		FunkinUpdate._update.push({
			cb: callback,
			interval: 1 / frameInterval,
			acc: onStart ? 1 / frameInterval : 0,
			lastCallTime: 0,
			active: true
		});
	},

	register_post: function(callback:Float->Dynamic, ?frameInterval:Float = 1000, ?onStart:Bool = true) {
		trace(frameInterval);
		FunkinUpdate._update_post.push({
			cb: callback,
			interval: 1 / frameInterval,
			acc: onStart ? 1 / frameInterval : 0,
			lastCallTime: 0,
			active: true
		});
	},

	unregister: function(callback:Float->Dynamic) {
		for (i in 0...FunkinUpdate._update.length) {
			if (FunkinUpdate._update[i].cb == callback) {
				FunkinUpdate._update[i].active = false;
				return;
			}
		}

		for (i in 0...FunkinUpdate._update_post.length) {
			if (FunkinUpdate._update_post[i].cb == callback) {
				FunkinUpdate._update_post[i].active = false;
				return;
			}
		}
	},
	
	cleanup: function() {
		var i = FunkinUpdate._update.length;
		while (i-- > 0) {
			if (!FunkinUpdate._update[i].active) {
				FunkinUpdate._update.splice(i, 1);
			}
		}
		
		i = FunkinUpdate._update_post.length;
		while (i-- > 0) {
			if (!FunkinUpdate._update_post[i].active) {
				FunkinUpdate._update_post.splice(i, 1);
			}
		}
	}
};

var __globalTime:Float = 0;
var __cleanupCounter:Int = 0;

function update(elapsed:Float) {
	__globalTime += elapsed;
	
	if (++__cleanupCounter >= 1000) {
		__cleanupCounter = 0;
		FunkinUpdate.cleanup();
	}
	
	if (FunkinUpdate._update.length == 0) return;

	var updates = FunkinUpdate._update;
	var i = updates.length;

	while (i-- > 0) {
		var u = updates[i];
		if (!u.active) continue;

		u.acc += elapsed;

		if (u.acc >= u.interval) {
			var realElapsed = __globalTime - u.lastCallTime;
			u.lastCallTime = __globalTime;

			var result = u.cb(realElapsed);

			if (result == false) {
				u.active = false;
				FunkinUpdate.cleanup();
			}

			u.acc -= u.interval;
		} else if (u.lastCallTime == 0) {
			u.lastCallTime = __globalTime;
			if (u.acc >= u.interval) {
				var result = u.cb(u.interval);

				if (result == false) {
					u.active = false;
					FunkinUpdate.cleanup();
				}
				u.acc -= u.interval;
			}
		}
	}
}

function postUpdate(elapsed:Float) {
	__globalTime += elapsed;
	if (FunkinUpdate._update_post.length == 0) return;

	var posts = FunkinUpdate._update_post;
	var i = posts.length;

	while (i-- > 0) {
		var p = posts[i];
		if (!p.active) continue;

		p.acc += elapsed;

		if (p.acc >= p.interval) {
			var realElapsed = __globalTime - p.lastCallTime;
			p.lastCallTime = __globalTime;

			var result = p.cb(realElapsed);

			if (result == false) {
				p.active = false;
			}
			
			p.acc -= p.interval;
		} else if (p.lastCallTime == 0) {
			p.lastCallTime = __globalTime;
			if (p.acc >= p.interval) {
				var result = p.cb(p.interval);

				if (result == false) {
					p.active = false;
				}
				p.acc -= p.interval;
			}
		}
	}
}