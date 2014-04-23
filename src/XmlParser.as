package  {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * This module parses the loaded xml we have to gave it and store it in an object we create
	 * @author Christian Krebs
	 */
	public class XmlParser extends EventDispatcher {
		private static var instance:XmlParser;	
		private var _wordsArray;
		
		/**
		* Constructor. This class is a singleton and this Constructor shouldn´t be call it. use instead the function getInstance(). 
		**/
		public function XmlParser(caller:Function = null) {
			if( caller != XmlParser.getInstance ){
				throw new Error ("XmlParser is a singleton class, use getInstance() instead");
			}
            if ( XmlParser.instance != null ) {
				throw new Error( "Only one XmlParser instance should be instantiated" );
			}
		}
		
		/**
		* get the instance of the singleton. In the case of no instance has been initialized,
		* the function call the constructor und return the new instance.
		* @return XmlParser instance of the singleton
		**/
		public static function getInstance():XmlParser {
			if (instance == null){
				instance = new XmlParser(arguments.callee);
			}
			return instance;
		}
		
		/*
		 * initialize the arrays
		 */
		public function init():void{
			_wordsArray = new Array();	// initialize the array
		}
		
		/*
		 * parses the given xml and stores the values to an array
		 * xml is the loaded xml
		 */
		public function parseXML(xml:XML):void {
			var numWords:int = xml.amountWords.@Number;	
			trace("amount different words: " + numWords);
			for (var i:int = 1; i < numWords+1; i++) {
				var tmpXMLList:XMLList = xml.word.(@id == i);		
				_wordsArray.push(String(tmpXMLList.name.@value));	
			}
			trace("xml parsed");
			this.dispatchEvent(new Event(Event.COMPLETE));	// if parsing is finished there will be an event we have to listen to react on this
		}

		/*
		 * returns the array which stores the words
		 */
		public function get wordsArray():Array {
			return _wordsArray;
		}
		
	}
}