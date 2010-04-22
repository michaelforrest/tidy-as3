package test.mvc.view 
{
	import tidy.mvc.view.TidyView;

	/**
	 * @author christian
	 */
	public class ViewBaseTestHelper extends TidyView 
	{
		public var myProperty : String;
		public function ViewBaseTestHelper(options : Object = null)
		{
			super(options);
		}
	}
}
