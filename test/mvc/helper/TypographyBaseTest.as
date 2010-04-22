package test.mvc.helper 
{
	import tidy.debug.Log;
	import flash.utils.ByteArray;
	import tidy.mvc.helper.TypographyBase;
	import asunit.framework.TestCase;

	/**
	 * @author christian
	 */
	public class TypographyBaseTest extends TestCase 
	{
		public function TypographyBaseTest(testMethod : String = null)
		{
			super(testMethod);
		}
		
		public function testClassicConstructor () : void
		{
			var styleName : String = "foo";
			new TypographyBase(styleName);
			assertEquals("Typography base should log an error if a missing style is passed", 'Style "' + styleName + '" not found on [object TypographyBase]', Log.defaultLogger.lastMessage);
			// style should have default values
			// the Log should have traced the warning for missing style
		}

		public function testGetTextWidth () : void
		{
			var style : TypographyBase = TypographyBase.getSystemFont();
			var w : Number = TypographyBase.getTextWidth(style, "W");
			assertTrue("TypographyBase.getTextWidth should return the text width, was:" + w, w>0);
		}
		
		public function testGetLineHeight () : void
		{
			var style : TypographyBase = TypographyBase.getSystemFont();
			var h : Number = TypographyBase.getLineHeight(style);
			assertTrue("TypographyBase.getLineHeight should return the text line height, was:" + h, h>0);
		}
		
		public function testClone () : void
		{
			var original : TypographyBase = new TypographyBase();
			var clone : TypographyBase = original.clone();
			assertNotSame("A cloned typography style should be different", original, clone);
			
			/* this is probably useless :S */
			var originalBa : ByteArray = new ByteArray();
			originalBa.writeObject(original);
			
			var cloneBa : ByteArray = new ByteArray();
			cloneBa.writeObject(clone);
			assertEquals("A cloned typography style should be the same size", originalBa.length, cloneBa.length);
		}
		
		public function testDoOneOrMultiLine () : void
		{
			var style : TypographyBase = new TypographyBase();
			//shake things up
			style.doOneLine();
			style.doMultiline();
			//
			style.doOneLine();
			assertEquals("doOneLine should change the wordWrap parameter", style.wordWrap, false);
			assertEquals("doOneLine should change the multiline parameter", style.multiline, false);			style.doMultiline();
			assertEquals("doMultiline should change the wordWrap parameter", style.wordWrap, true);			assertEquals("doMultiline should change the multiline parameter", style.multiline, true);
			
		}
	}
}
