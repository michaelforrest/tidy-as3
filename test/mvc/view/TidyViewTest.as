package test.mvc.view 
{
	import asunit.framework.TestCase;

	import tidy.mvc.view.TidyTextField;
	import tidy.mvc.view.TidyView;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author christian
	 */
	public class TidyViewTest extends TestCase 
	{
		public function TidyViewTest(testMethod : String = null)
		{
			super(testMethod);
		}
		
		public function testConstructor () : void
		{
			const VALUE : String = "foo";
			var view : ViewBaseTestHelper = new ViewBaseTestHelper({myProperty:VALUE});
			assertEquals("TidyView constructor should set parameters through options", VALUE, view.myProperty);
		}

		public function testAdd() : void
		{
			var tidyView : TidyView = new TidyView();
			var view : TidyView = tidyView.add(Sprite);
			assertEquals("If a class which doesn't extend TidyView is added", "tidy.mvc.view::TidyView", getQualifiedClassName(view));			assertEquals("The added class if not TidyView, will be added inside the created container", 1, view.numChildren);						view = tidyView.add(ViewBaseTestHelper);			assertEquals("A instance of a class extending TidyView will be added directly", "test.mvc.view::ViewBaseTestHelper", getQualifiedClassName(view));
			assertEquals("A instance of a class extending TidyView won't have auto-generated children", 0, view.numChildren);
		}
		
		public function testText() : void
		{
			var tidyView : TidyView = new TidyView();
			var txt : TextField;
			try{
				txt = tidyView.text(null);
				fail("text should  throw an error if the text is null");
			}catch(e : Error){
				
			}
			txt = tidyView.text("test");
			assertEquals("text should return a TidyView instance", "tidy.mvc.view::TidyTextField", getQualifiedClassName(txt));
			var s : * = (txt as TidyTextField).style;
			assertEquals("auto-generated text style should be TypographyBase", "tidy.mvc.helper::TypographyBase", getQualifiedClassName(s));
		}
		
		public function testAlign () : void
		{
			var container : TidyView = new TidyView();
			var g : Graphics = container.graphics;
			g.beginFill(0);
			g.drawRect(0,0, 800, 400);
			var child : TidyView = new TidyView();
			g = child.graphics;
			g.beginFill(0);
			g.drawRect(0, 0, 200, 100);
			container.addChild(child);
			container.align(child, new Point(.5, .5));
			assertEquals("align should center horizontally correctly based on child and parent sizes", 300, child.x);			assertEquals("align should center vertically correctly based on child and parent sizes", 150, child.y);
			container.align(child, new Point(.25, .25));			assertEquals("align should align horizontally correctly based on child and parent sizes", 150, child.x);
			assertEquals("align should align vertically correctly based on child and parent sizes", 75, child.y);
			container.align(child, new Point(.5, .5), new Point(300, 100), new Point(1000, 500));			assertEquals("align should center horizontally correctly based on child and parent given sizes", 350, child.x);
			assertEquals("align should center vertically correctly based on child and parent given sizes", 200, child.y);
			container.align(child, new Point(.25, .25), new Point(300, 100), new Point(1000, 500));
			assertEquals("align should align horizontally correctly based on child and parent sizes", 175, child.x);
			assertEquals("align should align vertically correctly based on child and parent sizes", 100, child.y);
		}
		
		public function testDispose () : void
		{
			var container : TidyView = new TidyView();
			container.add(TidyView);
			container.dispose();
			assertEquals("dispose should remove all the children", 0, container.numChildren);
		}
	}
}