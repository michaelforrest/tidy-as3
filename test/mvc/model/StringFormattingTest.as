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
			assertEquals("should format a date in hh:mm format","17:30", StringFormatting.formatTime24Hour(date));			assertEquals("should format a time in seconds to mm:ss:cc format", "01:22:40", StringFormatting.formatTimeInCentiseconds(82.40));			assertEquals("should format a time in seconds to mm:ss format", "01:22", StringFormatting.formatTimeInSeconds(82.40));
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
			assertEquals("should convert correctly a string which start with lower case", "my_test_text", StringFormatting.underscore("myTestText"));			assertEquals("should convert correctly a string which start with upper case", "my_test_text", StringFormatting.underscore("MyTestText"));
		}
		
		public function testTrim () : void
		{
			assertEquals("trim should trim both sides of a string", "final text", StringFormatting.trim("\t final text\t "));			assertEquals("trim left should trim the left side of a string", "final text\t ", StringFormatting.leftTrim("\t final text\t "));			assertEquals("trim right should trim the right side of a string", "\t final text", StringFormatting.rightTrim("\t final text\t "));
		}
		
		public function testSentenceCase () : void
		{
			assertEquals("should convert an undersocred text to a sentence like format", "My fantastic sentence", StringFormatting.sentenceCase("my_fantastic_sentence"));
		}
	}
}
