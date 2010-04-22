package test.debug 
{
	import asunit.framework.TestCase;

	import tidy.debug.Log;
	import tidy.debug.LogType;

	public class LogTest extends TestCase 
	{
		
		public function LogTest(testMethod : String = null) 
		{
			super(testMethod);
		}
	
		private var TEST_MESSAGE : String = "Ignore this message";
		
		public function testLevelSetting() : void 
		{
			Log.error(TEST_MESSAGE);
			assertEquals("Last message logged should be accessible via Log.getLastMessage()", TEST_MESSAGE, Log.getLastMessage());
			assertEquals("Last message type should be accessible via Log.getLastMessageType()", LogType.ERROR, Log.getLastMessageType());
		}
		
		public function testLevelSimple() : void
		{
			Log.clear();
			Log.setLogLevel(0);
			Log.error(TEST_MESSAGE);
			assertNull("If Log.getLevel() is equals to 0, errors shouldn't be traced", Log.getLastMessage());
			try{
				Log.fatal(TEST_MESSAGE);
			}catch( e : Error)
			{
			}
			assertEquals("If Log.getLevel() is equals to 0, only fatals should be traced", TEST_MESSAGE, Log.getLastMessage());
			Log.setLogLevel(5);
		}
		
		public function testCanClear() : void
		{
			Log.info(TEST_MESSAGE);
			Log.clear();
			assertNull("Log.clear() should set message to null", Log.getLastMessage());
			assertNull("Log.clear() should set last message type to null", Log.getLastMessageType());
		}
	}
}
