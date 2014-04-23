package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	/**
	 * document file
	 * @author Christian Krebs
	 */
	public class Main extends Sprite {
		private var _xmlLoader:XmlLoader;			// reference to xml loader
		private var _xmlParser:XmlParser;			// reference to xml parser
		private var _assetLoader:AssetLoader;		// reference to Asset loader
		private var _gameManager:GameManager;		// reference to Game Manager
		private var _soundSystem:SoundSystem;		// reference to Sound System
		
		public function Main():void {
			if (stage) {
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		/*
		 * initialize the xmlLoader
		 */
		private function init(e:Event = null):void {
			if(hasEventListener(Event.ADDED_TO_STAGE)){
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			trace("MAIN STAGE INITIALIZED");
			
			_xmlLoader = XmlLoader.getInstance();
			_xmlLoader.load("words.xml");
			_xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
		}
		
		/*
		 * initialize the xmlParser
		 */
		private function xmlLoaded(e:Event):void {
			_xmlLoader.removeEventListener(Event.COMPLETE, xmlLoaded);
			
			_xmlParser = XmlParser.getInstance();
			_xmlParser.init();
			_xmlParser.addEventListener(Event.COMPLETE, xmlParsed);
			_xmlParser.parseXML(_xmlLoader.xmlData);
		}
		
		/*
		 * initialize the AssetLoader
		 */
		private function xmlParsed(e:Event):void {
			_xmlParser.removeEventListener(Event.COMPLETE, xmlParsed);
			
			_assetLoader = AssetLoader.getInstance();
			_assetLoader.load("Assets.swf");
			_assetLoader.addEventListener(AssetLoader.ASSETS_LOADED, onAssetsCompleteLoaded);
		}
		
		/*
		 * initialize the GameManager
		 */
		private function onAssetsCompleteLoaded(e:Event):void {
			_assetLoader.removeEventListener(AssetLoader.ASSETS_LOADED, onAssetsCompleteLoaded);
			trace("ASSETS LOADED");
			
			_soundSystem = SoundSystem.getInstance();
			_soundSystem.init();
			
			_gameManager = GameManager.getInstance();
			_gameManager.init();
			this.addChild(_gameManager);
		}

	}
	
}