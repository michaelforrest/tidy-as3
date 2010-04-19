package tidy.debug 
{

	/**
	 * @author christian
	 */
	public interface ILogger 
	{
		function debug ( message : String ) :void;		function info ( message : String ) :void;		function warn ( message : String ) :void;		function error ( message : String ) :void;		function fatal ( message : String ) :void;
		/**
		 * log an error if a condition is true
		 * @param the condition which if true will trigger the error log
		 * @param the message to be eventually logged
		 */
		function assert( cond:Boolean, message : String):void;
		function log ( ...args : * ) : void;
		function get logLevel () : int;
		function set logLevel ( level : int ) : void;
		function clear () : void;
		function get lastMessage () : String;
		function get lastMessageType () : LogType;
	}
}
