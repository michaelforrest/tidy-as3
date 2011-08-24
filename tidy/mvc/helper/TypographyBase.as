package tidy.mvc.helper 
{
	import tidy.debug.Log;
	import tidy.mvc.view.PackableView;
	import tidy.mvc.view.TidyTextField;
	import tidy.mvc.view.TidyView;

	import flash.text.TextFormat;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	LBi Useful ActionScript 3 Library (ported from AS2 Library equivalent)
    Copyright (C) 2007 LBi / Michael Forrest

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 * This class eschews the usual naming conventions in favour of something
 * that looks a bit more like CSS. Override the Defaults() method to set the defaults.
 * <pre>
 * class app.helpers.Typography extends TypographyBase {

	private var WHITE : Number = 0xFFFFFF;

	private var ORANGE : Number = 0xF68B1E;

	function Typography(style:String) {
		super(style);
	}
	private function Defaults() : void{
		font = Linkages.ARIAL;
		colour = WHITE;
	}
	private function H1() : void{
		font_size = 24;
	}
	private function P() : void{
		font_size = 12;
	}
	private function Footer() : void{
		font_size = 16;
	}
	private function ItemHeading() : void{
		font_size = 16;
		bold = true;
		colour = ORANGE;
	}

}
 * </pre>
 *
 */
	public class TypographyBase
	{

		/**
		 * Returns the width of a string given a style
		 * @param the text style
		 * @param the text content
		 * @return the total width
		 *
		 * @author christian
		 */
		public static function getTextWidth (style : TypographyBase, text : String) : Number
		{
			var new_style : TypographyBase = style.clone();
			new_style.doOneLine();
			new_style.antiAliasType = "normal";
			var txt : TidyTextField = new TidyTextField(new_style);
			if(new_style.html){
				txt.htmlText = text;
			}else{
				txt.text = text;
			}
			return txt.textWidth;
		}
		
		/**
		 * Returns the height of a single line with the given style. It will use "W" as test character.
		 * @param the style
		 * @return the height of the line
		 *
		 * @author christian
		 */
		public static function getLineHeight ( style : TypographyBase) : Number
		{
			var new_style : TypographyBase = style.clone();
			new_style.doOneLine();
			new_style.antiAliasType = "normal";
			var txt : TidyTextField = new TidyTextField(new_style);
			txt.text = "W";
			return txt.textHeight;
		}
		
		public function TypographyBase(style:String = "") {
			Defaults();
			if(style && this.hasOwnProperty(style)) {
				this[style]();
			}else{
				Log.error("Style \"" + style + "\" not found on " + this);
			}
		}

		public function System() : void {
			embedFonts = false;
			font = "_sans";
			fontSize = 11;
			background = true;
		}

		public static function getSystemFont() : TypographyBase
		{
			return new TypographyBase("System");
		}

		public var verticalOffset : Number = 0;
		/*
		 * TextFormat stuff
		 */
		public var fontSize : Number = 12;
		public var font : String = "Bodyfont";
		public var color : Number = 0;
		public var bold : Boolean = false;
		public var italic : Boolean = false;
		public var underline : Boolean = false;
		public var url : String = "";
		public var target : String = "";
		public var align : String = "left";
		public var leftMargin : Number = 0;
		public var rightMargin : Number = 0;
		public var indent : Number = 0;
		public var leading : Number = 0;

		/*
		 * TextField parameters
		 */
		public var autoSize : String = "left";
		public var background : Boolean = false;
		public var html : Boolean = false;
		public var wordWrap : Boolean = true;
		public var multiline : Boolean = true;
		public var condenseWhite : Boolean = true;
		public var border : Boolean = false;
		public var selectable : Boolean = false;
		public var embedFonts : Boolean = true;
		public var type : String = "dynamic";
		/**
		 * Flash 8 only
		 * Can be "normal" or "advanced".
		 * @see gridFitType, thickness and sharpness
		 */
		public var antiAliasType:String = "normal";
		/**
		 * Flash 8 only
		 * Can be "none", "pixel" or "subpixel"
		 */
		public var gridFitType:String = "none";
		/**
		 * Flash 8 only
		 * In range -200 to 200
		 * The thickness of the glyph edges in this TextField
		 * instance. This property applies only
		 * when antiAliasType() is set to "advanced".
		 */
		public var thickness:Number = 0;
		public var maxChars : Number;
		/**
		 * Flash 8 only
		 * The range for sharpness is a number from -400 to 400.
		 */
		public var sharpness:Number = 0;
		/**
		 * Flash 8 only
		 * The amount of space that is uniformly distributed between characters.
		 */
		public var letterSpacing : Number = 0;
		
		public var kerning : Boolean = false;


		public var filters : Array = [];

		protected function Defaults() : void {
		}

		public function getTextFormat() : TextFormat{
			var tf : TextFormat = new TextFormat(font, fontSize, color,
									bold, italic, underline, url,target, align,
									leftMargin, rightMargin, indent, leading);
			tf.letterSpacing = letterSpacing;
			tf.kerning = kerning;
			return tf;
		}
		
		public function getTextFieldParams():Object{
			return {
				background: background,
				embedFonts: embedFonts,
				selectable: selectable,
				border: border,
				condenseWhite: condenseWhite,
				multiline: multiline,
				wordWrap: wordWrap,
				autoSize: autoSize,
				type: type,
				antiAliasType: antiAliasType,
				gridFitType: gridFitType,
				thickness: thickness,
				sharpness: sharpness,
				maxChars: maxChars,
				filters: filters
			};
		}
		
		/**
		 * Returns a copy of the style itself
		 * @return the copy
		 *
		 * @author christian
		 */
		public function clone () : TypographyBase
		{
			var attributes : Array = [
				"fontSize",
				"font",
				"color",
				"bold",
				"italic",
				"underline",
				"target",
				"url",
				"align",
				"leftMargin",
				"rightMargin",
				"indent",
				"leading",
				"autoSize",
				"background",
				"html",
				"wordWrap",
				"multiline",
				"condenseWhite",
				"border",
				"selectable",
				"embedFonts",
				"type",
				"antiAliasType",
				"gridFitType",
				"thickness",
				"sharpness",
				"maxChars",
				"letterSpacing",
				"kerning",
				"filters"];
			
			var res : TypographyBase = new TypographyBase("Defaults");
			for each(var attribute : String in attributes){
				res[attribute] = this[attribute];
			}
			return res;
		}
		
		/**
		 * Force the textfiled to be in one line setting wordWrap and multiline properties
		 *
		 * @author christian
		 */
		public function doOneLine () : void
		{
			wordWrap = false;
			multiline = false;
		}
		
		/**
		 * Force the textfiled to be in more than one line setting wordWrap and multiline properties
		 *
		 * @author christian
		 */
		public function doMultiline() : void
		{
			wordWrap = true;
			multiline = true;
		}
		
		public static function showAllStyles() : TidyView {
			var result : PackableView = new PackableView({columnWidth:800});
			var base : XML = describeType(getDefinitionByName("tidy.mvc.helper.TypographyBase"));
			var appTypography : XML = describeType(getDefinitionByName("app.helpers.Typography"));
			
			for each (var method:XML in appTypography.factory.method) {
				var inBaseClass : XMLList = base.factory.method.(attribute("name") == method.@name);
				if(inBaseClass.length() == 0){
					result.append(result.text(method.@name, method.@name));
				}
			}
			return result;
		}
	}
}
