package tidy.mvc.model {
	import tidy.debug.Log;

	/**
	 * @author michaelforrest
	 */
	public class Check {
		public static function notNull(source : Object, required_fields : Array) : void {
			Log.assert(source != null, "Check.notNull error: source not supplied");
			for each(var field : String in required_fields){
				Log.assert(source[field] != null, "Check.notNull error: field " + field + " is null on source " + source);
			}
		}
	}
}
