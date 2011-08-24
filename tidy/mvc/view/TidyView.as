package tidy.mvc.view 
{
	import flash.utils.getQualifiedClassName;
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
		protected var __animator : Animator;
		public function get animator () : Animator
		{
			if(__animator == null) {
				__animator = new Animator(this);
			}
			return __animator;
		}

		public function set animator (v : Animator) : void
		{
			__animator = v;
		}

		private var __visibility: Number = 1;
		
		public function get visibility():Number{
			return __visibility;
		}
		public function set visibility(v:Number):void{
			__visibility = v;
		}
		
		public var autoHide : Boolean = false;
		override public function set alpha ( v : Number ) : void
		{
			super.alpha = v;
			if(!autoHide)
				return;
			visible = v>0;
		}
		
		public function TidyView(options : Object = null) {
			setOptions(options);
		}
		
		protected function setOptions (options : Object = null) : void
		{
			for (var key : String in options){
				try{
					this[key] = options[key];
				}catch(e : Error){
					Log.warn("Couldn't set property \"" + key + "\" in class \"" + getQualifiedClassName(this) + "\"");
				}
			}
		}
		
		
		// TODO: refactor the following two methods.
		public function hide(options : Object = null) : TidyView {
			if(options && options.animate == false){
				visibility = 0;
			}else{
				animator.visibility = 0;
			}
			return this;
		}

		public function show(options : Object = null) : TidyView {
			if(options && options.animate == false){
				visibility = 1;
			}else{
				animator.visibility = 1;
			}
			return this;
		}

		/**
		 * TODO: think about a less nesty way to convert embedded classes into ViewBases.
		 */
		public function add(viewClass : Class, model:Object=null) : TidyView {
			Log.assert(viewClass != null, "viewClass is null!");
			var result : DisplayObject = model ? new viewClass(model) : new viewClass();
			var resultClass:Class = getClassByName("app.views.ViewBase", TidyView);
			if(!(result is resultClass)) {
				var child : DisplayObject = result;
				result = new resultClass();
				(result as TidyView).addChild(child);
			}
			addChild(result);
			return result as TidyView;
		}
		
		public function text(text : String, style : String="Paragraph", width : Number = NaN) : TidyTextField {
			Log.assert(text != null, "text can't be null");
			var typographyClass : Class = getClassByName("app.helpers.Typography", TypographyBase);
			var textField : TidyTextField = new TidyTextField(new typographyClass(style), text, isNaN(width) ? 800 : width );
			textField.height = textField.textHeight + 4; // if 2px padding is still the strange magic number
			addChild(textField);
			return textField;
		}
		
		protected function getClassByName (name : String, defaultClass : Class) : Class
		{
			var resultClass:Class;
			try{
				resultClass = getDefinitionByName(name) as Class;
			}catch (error : ReferenceError) {
				return defaultClass;
			}
			return resultClass;
		}

		public function get position():Point{
			return new Point(x,y);
		}
		public function set position(v : Point):void{
			x = v.x;
			y = v.y;
		}
		
		public function setPosition(...args) : TidyView {
			if(args[0] is Point) {
				var position : Point = args[0] as Point;
				x = position.x;
				y = position.y;
			}else{
				x = args[0];
				y = args[1];
			}
			return this;
		}

		public function align(child : DisplayObject, childPosition : Point, childSize : Point = null, parentSize : Point = null) : TidyView {
			if(!childSize) {
				childSize = new Point(child.width, child.height);
			}
			if(!parentSize) {
				parentSize = new Point(width,height);
			}
			child.x = ( parentSize.x - childSize.x) * childPosition.x;
			child.y = ( parentSize.y - childSize.y) * childPosition.y;
			return this;
		}
		
		public function get children () : Array
		{
			var results : Array = [];
			var len : int = numChildren;
			for(var i:uint=0; i<len; i++){
				results.push(getChildAt(i));
			}
			return results;
		}
		
		public function removeChildren() : void
		{
			var child : DisplayObject;
			while(numChildren>0){
				child = getChildAt(0);
				try{
					child["dispose"]();
				}catch(e:*){}
				if(child.parent)
					removeChild(child);
			}
		}
		
		/**
		 * Removes the TidyView
		 * 
		 * @author Christian Giordano
		 */
		public function dispose() : void
		{
			removeChildren();
			if(parent)	parent.removeChild(this);
		}
	}
}
