package tidy.mvc.view 
{
	import tidy.debug.Log;
	import tidy.mvc.helper.ColorHelper;
	import tidy.mvc.helper.TypographyBase;

	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author michaelforrest
	 */
	public class TidyTextField extends TextField {
		private var __style : TypographyBase;
		public function get style () : TypographyBase
		{
			return __style;
		}
		public function set style (v:TypographyBase) : void
		{
			__style = v;
			
			if(v.embedFonts && v.font.substr(0,1)=="_")
				Log.warn("The font name starts with \"_\" and the font is set as embedded");
			
			var formats:Object = __style.getTextFieldParams();
			for(var i:String in formats) this[i] = formats[i];
			var fmt : TextFormat = __style.getTextFormat();
			defaultTextFormat = fmt;
			setTextFormat(fmt);
		}
		
		public var autoAssignText : Boolean = true;
		
		override public function set text(value : String) : void
		{
			if(autoAssignText && __style.html){
				htmlText = value;
			}else{
				super.text = value;
			}
		}

		public function TidyTextField(style : TypographyBase = null, text : String = "", width : Number = 800) {
			this.style = style || new TypographyBase();
			this.width = width;
			
			this.text = text;
			
			if(!__style.multiline) width = textWidth + 4;
			
			//mouseWheelEnabled = false; used in Tonic
		}
		
		override public function set y(value : Number) : void {
			super.y = value + style.verticalOffset;
		}

		override public function get y() : Number {
			return super.y - style.verticalOffset;
		}
		
		public function invert(v : Number) : void {
			var inverse :Number = 0xFFFFFF - style.color;
			textColor = ColorHelper.interpolate(style.color, inverse, v);
		}

		
	}
}
