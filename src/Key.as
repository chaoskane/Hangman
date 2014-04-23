package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	/**
	 * create key of the virtual keyboard
	 * @author Christian Krebs
	 */
	public class Key extends Sprite {
		
		private var _assetReference:MovieClip;
		private var _letter:String;
		
		public function Key(assetReference:MovieClip) {
			if (assetReference) {
				_assetReference = assetReference;
				_assetReference.buttonMode = true;
				_assetReference.addEventListener(MouseEvent.MOUSE_OVER, onMouseEventHandler);
				_assetReference.addEventListener(MouseEvent.MOUSE_OUT, onMouseEventHandler);
				_assetReference.addEventListener(MouseEvent.CLICK, onMouseEventHandler);	
			}
			
		}
		
		/**
		 * on mouse event
		 * @param	e
		 */
		public function onMouseEventHandler(e:MouseEvent):void {
			e.stopImmediatePropagation();
			switch(e.type) {
				case MouseEvent.MOUSE_OVER:														
					var myGlow:GlowFilter = new GlowFilter(); 
					myGlow.inner=true; 
					myGlow.color = 0xF4FA58; 
					myGlow.blurX = 10; 
					myGlow.blurY = 10;
					_assetReference.filters = [myGlow];
					break;
				case MouseEvent.MOUSE_OUT:														
					_assetReference.filters = [];		
					break;
				case MouseEvent.CLICK:														
					this.dispatchEvent(new CustomEvents(CustomEvents.CLICK_ON_BUTTON));		
					break;
				default:
					trace("mouse event not handled: " + e.type);		
			}
		}
		
		/*
		 * set up the key
		 */
		public function setKeyText(letter:String) {
			if (letter.length == 1) {
				_letter = letter;
				_assetReference.letter.mouseEnabled		= false;
				_assetReference.letter.text = letter;
			}
		}
		
		public function get letter():String {
			return _letter;
		}
		
	}

}