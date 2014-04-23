package  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * loads the assets by the given source
	 * @author Christian Krebs
	 */
	public class AssetLoader extends EventDispatcher{
		private static var instance:AssetLoader;	// instance of this singleton class
		
		private var _loader:Loader;					// this is a flash module for loading images and SWF Movies
		
		public static const ASSETS_LOADED:String = "assets loaded";		
		
		/**
		* Constructor. This class is a singleton and this Constructor shouldn´t be call it. use instead the function getInstance(). 
		**/
		public function AssetLoader(caller:Function = null) {
			if( caller != AssetLoader.getInstance ){
				throw new Error ("AssetLoader is a singleton class, use getInstance() instead");
			}
            if ( AssetLoader.instance != null ) {
				throw new Error( "Only one AssetLoader instance should be instantiated" );
			}
		}
		
		/**
		* get the instance of the singleton. In the case of no instance has been initialized,
		* the function call the constructor und return the new instance.
		* @return AssetLoader instance of the singleton
		**/
		public static function getInstance():AssetLoader {
			if (instance == null){
				instance = new AssetLoader(arguments.callee);
			}
			return instance;
		}
		
		/*
		 * loads the .swf file we send as url
		 * @param url,		String 		our url, the path to the .swf file
		 */
		public function load(url:String):void {
			_loader = new Loader();						
			var context:LoaderContext = new LoaderContext();					// this is a flash module for storing options and data for the file to load
			context.applicationDomain = ApplicationDomain.currentDomain;		// defines if it is in homepage or desc flash player
			context.checkPolicyFile = false;
			
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressListener);	// adding a progress listener to get each progress
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadingComplete);  			// adding a complete listener to know if assets are complete loaded
			
			_loader.load(new URLRequest(url), context);	// load the assets by url / path and options of the data
		}
		
		/*
		 * is colled on a change of the loading process
		 * traces the progress in percentage
		 */
		private function progressListener(e:ProgressEvent):void {
			trace("LOADING: " + Math.floor((100*e.bytesLoaded)/e.bytesTotal) + "%");			// changes on Progress the percentage of loaded assets
		}
		
		/*
		 * event if the assets are loaded complete 
		 * dispatches an custom event if its complete, "assetsLoaded"
		 */
		private function loadingComplete(e:Event):void {
			trace("ASSET LOADING COMPLETE");
			this.dispatchEvent(new Event(ASSETS_LOADED));		// dispatches our custom event if it is completely loaded
		}
		
		public function getClassDefinition(name:String):* {
			if (_loader.contentLoaderInfo.applicationDomain.hasDefinition(name)) {
				return new (_loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class);
			}
			return null;
		}
				
		/*
		 * returns an asset by the given name
		 * if the asset is not found it returns nothing (a null reference)
		 * if the asset is found it converts it from the class to the movieclip and returns the movieclip
		 */
		public function getAsset(name:String):MovieClip {
			if (_loader.contentLoaderInfo.applicationDomain.hasDefinition(name)) {
				var cl:Class = 	_loader.contentLoaderInfo.applicationDomain.getDefinition(name)
								as Class;
				var mc:MovieClip = new cl() as MovieClip;
				return mc;
			}else {
				trace("Asset not found: " + name);
				return null;
			}
		}
		/*
		 * returns a bitmap by the given name
		 * if the bitmap is not found it returns nothing (a null reference)
		 * if the bitmap is found it converts it from the class to bitmapdata and after this it 
		 * creates the bitmap by the given data and returns it
		 */
		public function getBitmap(name:String):Bitmap {
			if (_loader.contentLoaderInfo.applicationDomain.hasDefinition(name)) {
				var cl:Class = 	_loader.contentLoaderInfo.applicationDomain.getDefinition(name)
								as Class;
				var bmpData:BitmapData = new cl() as BitmapData;
				return new Bitmap(bmpData);
			}else {
				trace("Asset not found: " + name);
				return null;
			}
		}
		
	}
}