package test 
{
	import asunit.textui.TestRunner;

	/**
	 * @author christian
	 */
	public class TidyTestsRunner extends TestRunner 
	{
		public function TidyTestsRunner()
		{
			start(AllTests, null, TestRunner.SHOW_TRACE);
		}
	}
}
