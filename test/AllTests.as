package test 
{
	import asunit.framework.TestSuite;

	import test.animation.animator.AnimatorTest;
	import test.debug.LbiLoggerTest;
	import test.debug.LogTest;
	import test.mvc.helper.ClonerTest;
	import test.mvc.helper.TypographyBaseTest;
	import test.mvc.model.CheckTest;
	import test.mvc.model.StringFormattingTest;
	import test.mvc.view.TidyViewTest;

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
			addTest(new ClonerTest());
			
			addTest(new TypographyBaseTest());
			addTest(new TidyViewTest());
			addTest(new CheckTest());
		}
	}
}
