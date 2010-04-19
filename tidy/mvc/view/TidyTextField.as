package tidy.mvc.view {
	import tidy.mvc.helper.ColorHelper;
	import tidy.mvc.helper.TypographyBase;

	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author michaelforrest
	 */
	public class TidyTextField extends TextField {
		public var style : TypographyBase;
		
		public function TidyTextField(style : TypographyBase, text : String = "", width : Number = 800) {
			this.style = style;
			this.width = width;
			
			var formats:Object = style.getTextFieldParams();
			for(var i:String in formats) this[i] = formats[i];
			var fmt : TextFormat = style.getTextFormat();
			defaultTextFormat = fmt;
			setTextFormat(fmt);
			
			filters = style.filters;
			
			this.text = text;
			
			if(!style.multiline) width = textWidth + 4;
			
		}
		
		override public function set y(value : Number) : void {
			super.y = value + style.vertical_offset;
		}

		override public function get y() : Number {
			return super.y - style.vertical_offset;
		}
		
		public function invert(v : Number) : void {
			var inverse :Number = 0xFFFFFF - style.colour;
			textColor = ColorHelper.interpolate(style.colour, inverse, v);
		}

		
	}
}
