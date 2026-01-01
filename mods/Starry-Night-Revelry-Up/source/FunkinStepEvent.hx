import haxe.ds.IntMap;

class FunkinStepEvent {
	public var event_queue_step:IntMap<Array<Void->Void>> = new IntMap();
	public var event_step:Bool = true;

	public function new() {
		Conductor.onStepHit.add(stepHit);
	}

	public function stepHit(step:Int) {
		if (!event_step)
			return;

		var events = event_queue_step.get(step);
		if (events == null)
			return;

		var i = events.length;
		while (i-- > 0) {
			events[i]();
		}

		event_queue_step.remove(step);
	}

	/**
	 * 创建基于时间的步数事件
	 * @param t 时间点
	 * @param callback 回调函数
	 * @param times 时间偏移数组
	 */
	public function createStep(t:Int, callback:Void->Void, ?times:Array<Float>) {
		if (callback == null)
			return;

		var baseStep = Math.floor(t);
		var timeCount = times != null ? times.length : 1;

		for (i in 0...timeCount) {
			var timeOffset = times != null ? times[i] : 0;
			var stepTime = baseStep + Math.floor(timeOffset);
			addEventAtStep(stepTime, callback);
		}
	}

	/**
	 * 创建绝对步数事件
	 * @param times 绝对步数数组
	 * @param callback 回调函数
	 */
	public function createStepAbsolute(?times:Array<Int>, callback:Void->Void) {
		if (callback == null)
			return;

		var timeCount = times != null ? times.length : 1;

		for (i in 0...timeCount) {
			var stepTime = times != null ? times[i] : 0;
			addEventAtStep(stepTime, callback);
		}
	}

	/**
	 * 创建周期性触发事件
	 * @param ranges 触发区间数组，每个元素为 [开始步数, 结束步数, 是否在开始触发, 是否在结束触发]
	 * @param intervals 间隔配置，可以是 [间隔] 或 [间隔, 偏移]
	 * @param callback 触发时的回调函数
	 */
	public function createStepPeriodic(ranges:Array<Array<Dynamic>>, intervals:Array<Array<Int>>, callback:Void->Void) {
		if (callback == null || ranges == null || intervals == null)
			return;

		var intervalCount = intervals.length;

		for (i in 0...ranges.length) {
			var range = ranges[i];
			if (range == null || range.length < 2)
				continue;

			var startStep:Int = range[0];
			var endStep:Int = range[1];

			var intervalConfig = intervals[i % intervalCount];
			var interval:Int = intervalConfig[0];
			var offset:Int = intervalConfig.length > 1 ? intervalConfig[1] : 0;

			if (range.length > 2 ? range[2] : true)
				addEventAtStep(startStep, callback);
			if (range.length > 3 ? range[3] : true)
				addEventAtStep(endStep, callback);

			var currentStep = startStep + offset + interval;
			while (currentStep <= endStep - 1) {
				addEventAtStep(currentStep, callback);
				currentStep += interval;
			}
		}
	}

	/**
	 * 创建基于节拍的事件
	 * @param t 时间点
	 * @param callback 回调函数
	 * @param times 时间偏移数组
	 */
	public function createBeat(t:Float, callback:Void->Void, ?times:Array<Float>) {
		if (callback == null)
			return;

		var beatStep = Math.floor(t * 4);
		var timeCount = times != null ? times.length : 1;

		for (i in 0...timeCount) {
			var timeOffset = times != null ? times[i] * 4 : 0;
			var stepTime = beatStep + Math.floor(timeOffset);
			addEventAtStep(stepTime, callback);
		}
	}

	/**
	 * 创建绝对节拍事件
	 * @param times 绝对节拍数组
	 * @param callback 回调函数
	 */
	public function createBeatAbsolute(?times:Array<Int>, callback:Void->Void) {
		if (callback == null)
			return;

		var timeCount = times != null ? times.length : 1;

		for (i in 0...timeCount) {
			var stepTime = times != null ? times[i] * 4 : 0;
			addEventAtStep(stepTime, callback);
		}
	}

	/**
	 * 清除所有事件
	 */
	public function removeAll() {
		event_queue_step = new IntMap();
		event_step = true;
	}

	/**
	 * 卸载所有事件
	 */
	public function destroy() {
		Conductor.onStepHit.remove(stepHit);
		event_queue_step = null;
		event_step = null;
	}

	/**
	 * 在指定步数添加事件
	 */
	private function addEventAtStep(step:Int, callback:Void->Void) {
		var eventList = event_queue_step.get(step);
		if (eventList == null) {
			eventList = [];
			event_queue_step.set(step, eventList);
		}
		eventList.push(callback);
	}
}