package tidy.debug 
{

	/**
	 * @author christian
	 */
	public class LoggerBase implements ILogger 
	{
		private const DEFAULT_LEVEL : int = 5;
		protected var __logLevel : int = DEFAULT_LEVEL;
		public function get logLevel() : int
		{
			return __logLevel;
		}
		public function set logLevel(level : int) : void
		{
			__logLevel = level;
		}
		
		protected var __lastMessage : String;
		public function get lastMessage () : String
		{
			return __lastMessage;
		}
		
		protected var __lastMessageType : LogType;
		public function get lastMessageType () : LogType
		{
			return __lastMessageType;
		}

		public function LoggerBase() {
			
		}
		public function debug(message : String) : void
		{
			output(LogType.DEBUG, message);
		}
		
		public function info(message : String) : void
		{			output(LogType.INFO, message);
		}
		
		public function warn(message : String) : void
		{			output(LogType.WARNING, message);
		}
		
		public function error(message : String) : void
		{			output(LogType.ERROR, message);
		}
		
		public function fatal(message : String) : void
		{
			throw new Error(message);
		}

		public function assert( cond:Boolean, message : String):void
		{
			if( !cond )
				fatal( message );
		}
		
		public function log(...args : *) : void
		{
			trace.apply(null, args);
		}
		
		private function output(type : LogType, message : String) : void
		{
			if(__logLevel < type.level) return;
			__lastMessageType = type;
			__lastMessage = message;
			
			log("[" + type + "] " + message);
		}
		
		public function clear() : void
		{
			__lastMessage = null;
			__lastMessageType = null;
		}
	}
}
