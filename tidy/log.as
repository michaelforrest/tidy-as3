package tidy
{
	import tidy.debug.Log;
	/**
	 * @author christian
	 */
	public function log(...args : *) : void
	{
		Log.log.apply(null, args);
	}
}
