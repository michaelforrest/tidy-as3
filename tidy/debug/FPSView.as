package tidy.debug {
	import tidy.mvc.view.TidyView;

	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;

	/**
	 * @author michaelforrest
	 * (based on http://kaioa.com/node/83)
	 */
	public class FPSView extends TidyView {
		private var last : uint = getTimer();
		private var ticks : uint = 0;
		private var label : TextField;

		public function FPSView() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage,false,0,true);
		}

		private function onAddedToStage(event : Event) : void {
			label = text("","FPS", 50);
			addEventListener(Event.ENTER_FRAME, onEnterFrame,false,0,true);
		}

		private function onEnterFrame(event : Event) : void {
			ticks++;
			var now : uint = getTimer();
			var delta : uint = now - last;
			if (delta >= 500) {
				var fps : Number = ticks / delta * 1000;
				label.text = fps.toFixed(1) + " fps";
				ticks = 0;
				last = now;
			}
		}
	}
}
