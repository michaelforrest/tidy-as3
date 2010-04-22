package test.debug 
{
	import tidy.debug.LogType;
	import tidy.debug.LbiLogger;
	import asunit.framework.TestCase;

	/**
	 * @author christian
	 */
	public class LbiLoggerTest extends TestCase 
	{
		private var TEST_MESSAGE : String = "Ignore this message";
		
		private var log : LbiLogger;
		
		public function LbiLoggerTest(testMethod : String = null)
		{
			super(testMethod);
			
			log = new LbiLogger();
		}
		
		public function testCustom() : void
		{
			log.custom(TEST_MESSAGE, 0xFF0000, 0xFFFF00, true);
			assertEquals("log.custom should use LogType.CUSTOM", LogType.CUSTOM, log.lastMessageType);
			assertEquals("log.custom should generate a proper formatted string", "[custom foreground=#ff0000 background=#ffff00 bold=true] " + TEST_MESSAGE, log.lastMessage);
		}
		
		public function testGroup() : void
		{
			log.createGroup("navigation", 0xFF0000, 0xFFFF00, true);
			assertEquals("log.createGroup should use LogType.CUSTOM", LogType.CUSTOM, log.lastMessageType);
			assertEquals("log.createGroup should generate a proper formatted string", "[setup-group navigation foreground=#ff0000 background=#ffff00 bold=true]", log.lastMessage);
			log.group("navigation", TEST_MESSAGE);
			assertEquals("log.group should use LogType.CUSTOM", LogType.CUSTOM, log.lastMessageType);
			assertEquals("log.group should generate a proper formatted string", "[group navigation] " + TEST_MESSAGE, log.lastMessage);
		}
		
		public function testElement() : void
		{
			log.createElement("com.lbi.class", 0x00FF00, 0x00FFFF);
			assertEquals("log.createElement should use LogType.CUSTOM", LogType.CUSTOM, log.lastMessageType);
			assertEquals("log.createElement should generate a proper formatted string", "[setup-element com.lbi.class foreground=#00ff00 background=#00ffff]", log.lastMessage);
			log.element("com.lbi.class", TEST_MESSAGE);
			assertEquals("log.element should use LogType.CUSTOM", LogType.CUSTOM, log.lastMessageType);
			assertEquals("log.element should generate a proper formatted string", "[element com.lbi.class] " + TEST_MESSAGE, log.lastMessage);
		}
		
		public function testLevelAdvanced() : void
		{
			log.clear();
			log.logLevel = 0;
			log.createGroup("navigation", 0xFF0000, 0xFFFF00, true);
			log.group("navigation", TEST_MESSAGE);
			assertEquals("If the group doesn't have a level defined, it should always be traced", "[group navigation] " + TEST_MESSAGE, log.lastMessage);
			log.createGroup("data", 0xFF0000, 0xFFFF00, true, 1);
			log.clear();
			log.group("data", TEST_MESSAGE);
			assertNull("If the group has an higher level, it shouldn't be traced", log.lastMessage);
			log.logLevel = 2;
			log.clear();
			log.group("data", TEST_MESSAGE);
			assertEquals("If the group has a higher level, it should be traced", "[group data] " + TEST_MESSAGE, log.lastMessage);
			log.createGroup("data", 0xFF0000, 0xFFFF00, true);
			log.logLevel = 0;
			log.clear();
			log.group("data", TEST_MESSAGE);
			assertEquals("If the group doesn't have a level defined, it should always be traced", "[group data] " + TEST_MESSAGE, log.lastMessage);
			log.logLevel = 5;
		}
	}
}
