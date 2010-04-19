package tidy.debug {

	/**
	 * @author chrgio
	 */
	public class Log
	{
		

		public static function setLogLevel( level : Number ) : void
		{
			__defaultLogger.logLevel = level;
		}

		public static function getLogLevel() : Number
		{
//			if(isNaN(log_level)){
//				// In this first iteration I wasn't able to get the parameter from the html :S
//				var app : Object = Application.application;
//				var level : Number;
//				if(app != null) level = app["parameters"]["log_level"] as Number;
//				log_level = (!isNaN(level) ? level : DEFAULT_LEVEL);
//			}
			return __defaultLogger.logLevel;
		}

		public static var __defaultLogger : ILogger = new LoggerBase();
		public static function get defaultLogger () : ILogger
		{
			return __defaultLogger;
		}
		public static function set defaultLogger (v:ILogger) : void
		{
			__defaultLogger = v;
		}
		
		public static function debug(message : String) : void
		{
			__defaultLogger.debug(message);
		}

		public static function info(message : String) : void
		{
			__defaultLogger.info(message);
		}

		public static function warn(message : String) : void
		{
			__defaultLogger.warn(message);
		}

		public static function error(message : String) : void
		{
			__defaultLogger.error(message);
		}

		public static function fatal(message : String) : void
		{
			__defaultLogger.fatal(message);
		}
		
		public static function log(...args : *) : void
		{
			__defaultLogger.log.apply(null, args);
		}

		public static function getLastMessage() : String
		{
			return __defaultLogger.lastMessage;
		}

		public static function getLastMessageType() : LogType
		{
			return __defaultLogger.lastMessageType;
		}

		public static function clear() : void
		{
			__defaultLogger.clear();
		}
		
		public static function assert( cond:Boolean, message : String):void
		{
			__defaultLogger.assert(cond, message);
		}
	}
}
