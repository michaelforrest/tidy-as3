package tidy.debug 
{

	/**
	 * @author christian
	 */
	public class LbiLogger extends LoggerBase 
	{
		// these are set in the logger as well
		private const DEFAULT_BACKGROUND : Number = 0xFFFFFF;
		private const DEFAULT_FOREGROUND : Number = 0x000000;
		private var items : Array;

		public function LbiLogger()
		{
			super();
		}
		
		/**
		 * I T E M S
		 */
		public function createGroup(id : String, foregroundColour : Number = NaN, backgroundColour : Number = NaN, bold : Boolean = false, level : int = 0) : void
		{
			createItemCommand(LogItemType.GROUP, id, foregroundColour, backgroundColour, bold, level);
		}
		
		public function group( id : String, message : String ) : void
		{
			item(LogItemType.GROUP, id, message);
		}
		
		public function createElement(id : String, foregroundColour : Number = NaN, backgroundColour : Number = NaN, bold : Boolean = false, level : int = 0) : void
		{
			createItemCommand(LogItemType.ELEMENT, id, foregroundColour, backgroundColour, bold, level);
		}
		
		public function element( id : String, message : String ) : void
		{
			item(LogItemType.ELEMENT, id, message);
		}
		
		private function registerItem(type : LogItemType, id : String, level : Number) : void
		{
			if(items == null) items = [];
			items[getItemId(type, id)] = level;
		}
		
		private function createItemCommand(type : LogItemType, id : String, foregroundColour : Number, backgroundColour : Number, bold : Boolean, level : int = 0 ) : void
		{
			if(id.split(" ").length > 1) {
				error("Log::createItemCommand, id shouldn't contain empty spaces");
				return;
			}
			var command : String = "[setup-" + type + " " + id;
			if(isNaN(foregroundColour))
				foregroundColour = DEFAULT_FOREGROUND;
			if(isNaN(backgroundColour))
				backgroundColour = DEFAULT_BACKGROUND;
				
			if(foregroundColour != DEFAULT_FOREGROUND)
				command += " foreground=#" + getHex(foregroundColour);
			if(backgroundColour != DEFAULT_BACKGROUND)
				command += " background=#" + getHex(backgroundColour);
			if(bold == true)
				command += " bold=true";
			command += "]";

			registerItem(type, id, level);

			__lastMessageType = LogType.CUSTOM;
			__lastMessage = command;

			log(command);
		}
		 
		private function item(type : LogItemType, id : String, message : String) : void
		{
			var itemLevel : Number = items[getItemId(type, id)] || 0;
			if(__logLevel < itemLevel) return;

			__lastMessageType = LogType.CUSTOM;
			__lastMessage = "[" + type + " " + id + "] " + message;
			
			log(lastMessage);
		}
		
		private function getItemId( type : LogItemType, id : String ) : String
		{
			return type + "-" + id;
		}
		
		
		/**
		 *   C U S T O M
		 */
		public function custom( message : String, foregroundColour : Number = NaN, backgroundColour : Number = NaN, bold : Boolean = false, level : int = 0 ) : void
		{
			if(__logLevel < level) return;
			var command : String = "[custom";
			if(isNaN(foregroundColour))
				foregroundColour = DEFAULT_FOREGROUND;
			if(isNaN(backgroundColour))
				backgroundColour = DEFAULT_BACKGROUND;
			
			if(foregroundColour != DEFAULT_FOREGROUND)
				command += " foreground=#" + foregroundColour.toString(16);
			if(backgroundColour != DEFAULT_BACKGROUND)
				command += " background=#" + backgroundColour.toString(16);
			if(bold == true)
				command += " bold=true";
			command += "] " + message;

			__lastMessageType = LogType.CUSTOM;
			__lastMessage = command;

			log(command);
		}
		
		private static function getHex( colour : Number ) : String
		{
			var hex : String = colour.toString(16);
			for (var i : Number = hex.length;i < 6; i++)  hex = "0" + hex;
			return hex;
		}
	}
}
