package test.animation.animator 
{
	import tidy.animation.animator.Transition;
	import tidy.animation.util.Easing;
	import tidy.mvc.view.TidyView;
	import tidy.animation.animator.Animator;
	import asunit.framework.TestCase;

	/**
	 * @author christian
	 */
	public class AnimatorTest extends TestCase 
	{
		public function AnimatorTest(testMethod : String = null)
		{
			super(testMethod);
		}
		
		public function testDefaultProperties () : void
		{
			var view : TidyView = new TidyView();
			var animator : Animator = view.animator;
			
			var newEase : Function = Easing.easeOutQuint;
			var newFrames : int = 30;
			animator.setDefaultEasing(newEase).setDefaultFrames(newFrames);
			var transition : Transition = animator.change("alpha");
			assertEquals("Default easing should be passed to newly created transitions", newEase, transition.easing);			assertEquals("Default frames should be passed to newly created transitions", newFrames, transition.frames);
		}
		
		public function testIsAnimating () : void
		{
			var view : TidyView = new TidyView();
			var animator : Animator = view.animator;
			assertFalse("isAnimating should return false if animation has been triggered", animator.isAnimating("alpha"));
			animator.alpha = 0;			assertTrue("isAnimating should return true if animation has been just triggered", animator.isAnimating("alpha"));
		}
	}
}
