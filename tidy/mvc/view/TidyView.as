package tidy.mvc.view 
{
	import tidy.animation.animator.Animator;
	import tidy.debug.Log;
	import tidy.mvc.helper.TypographyBase;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;

	/**
	 * @author michaelforrest
	 */
	public class TidyView extends Sprite {
		public var animator : Animator;
		private var __visibility: Number;
		
		public function get visibility():Number{
			return __visibility;
		}
		public function set visibility(v:Number):void{
			__visibility = v;
		}
		public function TidyView(options : Object = null) {
			if(options) for (var key : String in options) this[key] = options[key];
			animator = new Animator(this);
			visibility = 1;
		}
		public function hide() : void {
			animator.visibility = 0;
		}

		public function show() : void {
			animator.visibility = 1;
		}

		/**
		 * TODO: think about a less nesty way to convert embedded classes into ViewBases.
		 */
		public function add(viewClass : Class, model:Object=null) : TidyView {
			Log.assert(viewClass != null, "viewClass is null!");
			var result : DisplayObject = model ? new viewClass(model) : new viewClass();
			var resultClass:Class = getDefinitionByName("app.views.ViewBase") as Class || TidyView;
			if(!(result is resultClass)) {
				var child : DisplayObject = result;
				result = new resultClass();
				(result as TidyView).addChild(child);
			}
			addChild(result);
			return result as TidyView;
		}
		
		public function text(text : String, style : String="Paragraph", width : Number = 800) : TidyTextField {
			if(text == null) trace("Error trying to set text of " + this + " to null" );
			var typographyClass : Class = getDefinitionByName("app.helpers.Typography") as Class || TypographyBase;
			
			var textField : TidyTextField = new TidyTextField(new typographyClass(style), text, width);
			textField.text = text;
			textField.height = textField.textHeight + 4; // if 2px padding is still the strange magic number
			addChild(textField);
			return textField;
		}
		
		public function get position():Point{
			return new Point(x,y);
		}
		public function set position(v : Point):void{
			x = v.x;
			y = v.y;
		}
		
		public function setPosition(...args) : void {
			if(args[0] is Point) {
				var position : Point = args[0] as Point;
				x = position.x;
				y = position.y;
			}else{
				x = args[0];
				y = args[1];
			}
		}

		public function align(child : DisplayObject, childPosition : Point, childDimensions : Point = null, parentDimensions : Point = null) : void {
			if(!childDimensions) {
				childDimensions = new Point(child.width, child.height);
			}
			if(!parentDimensions) {
				parentDimensions = new Point(width,height);
			}
			child.x = ( parentDimensions.x - childDimensions.x) * childPosition.x;
			child.y = ( parentDimensions.y - childDimensions.y) * childPosition.y;
		}
		
		
		
	}
}
