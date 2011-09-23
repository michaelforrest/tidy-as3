package tidy.mvc.helper {

	/**
	 * @author michaelforrest
	 * [shamelessly pasted (this time) from http://stackoverflow.com/questions/1350315/actionscript-3-0-color-interpolation-question]
	 */
	public class ColorHelper {
		public static function interpolate(fromColor :uint ,  toColor : uint, progress : Number) : uint{
			var q:Number = 1-progress;
		    var fromA:uint = (fromColor >> 24) & 0xFF;
		    var fromR:uint = (fromColor >> 16) & 0xFF;
		    var fromG:uint = (fromColor >>  8) & 0xFF;
		    var fromB:uint =  fromColor        & 0xFF;
		
		    var toA:uint = (toColor >> 24) & 0xFF;
		    var toR:uint = (toColor >> 16) & 0xFF;
		    var toG:uint = (toColor >>  8) & 0xFF;
		    var toB:uint =  toColor        & 0xFF;
		
		    var resultA:uint = fromA*q + toA*progress;
		    var resultR:uint = fromR*q + toR*progress;
		    var resultG:uint = fromG*q + toG*progress;
		    var resultB:uint = fromB*q + toB*progress;
		    var resultColor:uint = resultA << 24 | resultR << 16 | resultG << 8 | resultB;
		    return resultColor;  
		}
		// from http://snipt.net/tafaridh/conver-rgb-values-to-hex-string-or-number-and-back/
		// TODO: clean up.
		public static function stringToNumber(str:String, base:Number=16):Number {
			//trace("we start with "+str);
			var nVal:Number = 0;
			var tVal:Number = 0;
			var charz:Array = str.split("");
			charz.reverse();
			for (var a:int; a<charz.length; a++) {
				nVal = 0;
				var val:String = charz[a];
				if (!isNaN(Number(val))) {
					//trace("should be a Number="+val);
					nVal = Number(val);
				} else {
					val = val.toLocaleLowerCase();
					switch (val) {
						case "a" :
							nVal = 10;
							break;
						case "b" :
							nVal = 11;
							break;
						case "c" :
							nVal = 12;
							break;
						case "d" :
							nVal = 13;
							break;
						case "e" :
							nVal = 14;
							break;
						case "f" :
							nVal = 15;
							break;
						default :
							charz.splice(charz.indexOf(val),1);
							a--;
							//trace(val+" is not a valid value");
							break;
					}
				}
				var pwr :Number = Math.pow(base, a);
				//trace("pwr = "+pwr);
				nVal *= pwr;
				tVal += nVal;
				//trace(a+"start = "+val+", new = "+nVal+", total = "+tVal);
			}
			return tVal;
		}
	}
}
