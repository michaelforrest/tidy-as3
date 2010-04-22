package test.mvc.model 
{
	import tidy.mvc.model.StringFormatting;
	import asunit.framework.TestCase;

	/**
	 * @author christian
	 */
	public class StringFormattingTest extends TestCase 
	{
		public function StringFormattingTest(testMethod : String = null)
		{
			super(testMethod);
		}
		
		public function testTime () : void
		{
			var date : Date = new Date(2010,4,23,17,30,15,220);
			assertEquals("should format a date in hh:mm format","17:30", StringFormatting.formatTime24Hour(date));
		}
		
		public function testCamelize () : void
		{
			assertEquals("should convert correctly a string",  "myTestText", StringFormatting.camelize("my_test_text"));
		}
		
		public function testVariablify () : void
		{
			assertEquals("should convert correctly a string", "my_variable_test_name", StringFormatting.variablify("my.variable-test name"));
		}
		
		public function testPascalize () : void
		{
			assertEquals("should convert correctly a string", "MyTestText", StringFormatting.pascalize("my_test_text"));
		}
		
		public function testUnderscore () : void
		{
			assertEquals("should convert correctly a string which start with lower case", "my_test_text", StringFormatting.underscore("myTestText"));
		}
		
		public function testTrim () : void
		{
			assertEquals("trim should trim both sides of a string", "final text", StringFormatting.trim("\t final text\t "));
		}
		
		public function testSentenceCase () : void
		{
			assertEquals("should convert an undersocred text to a sentence like format", "My fantastic sentence", StringFormatting.sentenceCase("my_fantastic_sentence"));
		}
	}
}