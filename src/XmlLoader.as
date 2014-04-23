package  {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * loads the xml
	 * @author Christian Krebs
	 */
	public class XmlLoader extends EventDispatcher{
		private static var instance:XmlLoader;		// instance of this singleton class
		private var _xmlData:XML;					// flash datatype which stores the loaded xml data
		
		/**
		* Constructor. This class is a singleton and this Constructor shouldn´t be call it. use instead the function getInstance(). 
		**/
		public function XmlLoader(caller:Function = null) {
			if( caller != XmlLoader.getInstance ){
				throw new Error ("XmlLoader is a singleton class, use getInstance() instead");
			}
            if ( XmlLoader.instance != null ) {
				throw new Error( "Only one XmlLoader instance should be instantiated" );
			}
		}
		
		/**
		* get the instance of the singleton. In the case of no instance has been initialized,
		* the function call the constructor und return the new instance.
		* @return XmlLoader instance of the singleton
		**/
		public static function getInstance():XmlLoader {
			if (instance == null){
				instance = new XmlLoader(arguments.callee);
			}
			return instance;
		}
		
		/*
		 * loads the xml by given source
		 * @param source, 		String		is the path of the .xml file
		 */
		public function load(source:String):void {
			var urlLoader:URLLoader = new URLLoader();							// url loader loads the data (i.e. xml or txt files) from an given url
			urlLoader.addEventListener(Event.COMPLETE, loadingComplete);		// adding loading complete listener
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);	// adding input / output error listener
			urlLoader.load(new URLRequest(source));								// load the xml from the given source / path / homepage / url
		}
		
		/*
		 * is called if the .xml file is completly loaded
		 * dispatches the "complete" event
		 */
		private function loadingComplete(e:Event):void {
			trace("XML LOADING COMPLETE");
			_xmlData = new XML(e.target.data); 		// takes the caller data, which is the data of the xml
			this.dispatchEvent(new Event(Event.COMPLETE));	// we say here that out loading is complete, to listen from out of this module
		}
		
		/*
		 * is called if there is an input/output error (e.g. wrong file name, file not found, ...)
		 */
		private function ioErrorHandler(e:IOErrorEvent):void {
			trace("ERROR: " + e.errorID);
		}
		
		/*
		 * returns the loaded data from the xml
		 */
		public function get xmlData():XML {
			return _xmlData;
		}
		
	}
}