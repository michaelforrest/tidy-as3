package test 
{
	import test.mvc.helper.ClonerTest;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import tidy.mvc.helper.Cloner;
	import tidy.mvc.helper.TypographyBase;
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
			addTest(new ClonerTest());
			
			addTest(new TypographyBaseTest());
			addTest(new TidyViewTest());
			addTest(new CheckTest());
		}
	}
}
