package tidy.mvc.view {
	import tidy.mvc.collection.Collection;

	import flash.display.DisplayObject;

	/**
	 * @author michaelforrest
	 */
	public class PackableView extends TidyView {
		public static const HORIZONTAL : String = "horizontal";
		public static const VERTICAL : String = "vertical";

		private var nextX : Number = 0;
		public var nextY : Number = 0;
		public var spacing : Number = 0;
		public var paddingLeft : Number = 0;
		public var columnWidth : Number = 200;
		private var elements : Collection;
		public var paddingTop : Number = 0;
		private var maxHeight : Number;
		private var maxWidth : Number;

		private var maxRowHeight : Number = 0;

		public function PackableView(options : Object = null) {
			super(options);
			elements = new Collection();

			nextX = paddingLeft;
			nextY = paddingTop;
		}

		
		override protected function setOptions(options : Object = null) : void 
		{
			for (var key : String in options){
				// if the options can be set, it won't be set anymore by the super
				try{
					this[key] = options[key];
					delete options[key];
				}catch(e : Error){
				}
			}
			super.setOptions(options);
		}
		
		public function append(element : DisplayObject, options:Object = null) : DisplayObject {
			if(!element.parent) addChild(element);
			placeElement(element,options);
			elements.add(element);
			return element;
		}

		private var orientation : String = VERTICAL;
		public function setFlow(orientation : String) : void {
			this.orientation = orientation;
		}

		protected function get packedElements() : Collection{
			return elements;
		}

		protected function placeElement(element : DisplayObject,options:Object = null) : void {
			var offset : Number = options && !isNaN(options.offset) ? options.offset : 0;
			if(orientation == VERTICAL){
				if(maxHeight && nextY + element.height  > maxHeight) {
					nextY = paddingTop;
					nextX += columnWidth + spacing;
				}
				nextY += offset;
				moveElement(element,nextX,nextY);
				nextY += element.height + spacing;
			}else{
				maxRowHeight = Math.max(maxRowHeight, element.height);
				if(maxWidth && nextX + element.width > maxWidth) {
					nextY += maxRowHeight + spacing;
					nextX = paddingLeft;
					maxRowHeight = 0;
				}
				nextX += offset;
				moveElement(element,nextX,nextY);
				nextX = element.x + element.width + spacing;
			}
		}
		
		public function moveElement(element : DisplayObject, nextX : Number, nextY : Number) : void {
			element.x = nextX;
			element.y = nextY;
		}
		
		
		public function row(views : Array) : void {
			var nextX : Number = paddingLeft;
			var maxHeight : Number = 0;
			for (var i : Number = 0; i < views.length; i++) {
				var view:DisplayObject = views[i];
				if(!view.parent) addChild(view);
				view.y = nextY;
				view.x = nextX;
				nextX += view.width + spacing;
				if(view.height > maxHeight) maxHeight = view.height;
				elements.add(view);
			}
			nextY += maxHeight + spacing;
		}
		public function layoutElements() : void {
			nextX = paddingLeft;
			nextY = paddingTop;
			for (var i : Number = 0; i < elements.length; i++) {
				var element:DisplayObject = elements[i];
				placeElement(element);

			}
		}
		public function clear() : void {
			for (var i : Number = 0;i < elements.length; i++) {
				var element:DisplayObject = elements[i];
				removeChild(element);
				element = null;
			}
			elements = new Collection();
			nextY = paddingTop;
			nextX = paddingLeft;
		}

		override public function text(text : String, style : String = "Paragraph", width : Number = NaN) : TidyTextField {
			return super.text(text, style, isNaN(width) ? columnWidth : width);
		}
		
	}
}
