package test 
{
	import test.debug.LbiLoggerTest;
	import test.debug.LogTest;
	import test.mvc.model.StringFormattingTest;
	import test.animation.animator.AnimatorTest;
	import test.mvc.model.CheckTest;
	import test.mvc.view.TidyViewTest;
	import asunit.framework.TestSuite;

	import test.mvc.helper.TypographyBaseTest;

	/**
	 * @author christian
	 */
	public class AllTests extends TestSuite 
	{
		public function AllTests()
		{
			super();
			
			addTest(new AnimatorTest());
			
			addTest(new LbiLoggerTest());			addTest(new LogTest());
			
			addTest(new StringFormattingTest());
			
			addTest(new TypographyBaseTest());
			addTest(new TidyViewTest());
			addTest(new CheckTest());
		}
	}
}
