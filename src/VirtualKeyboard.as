package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * creates virtual keyboard for user input
	 * @author Christian Krebs
	 */
	public class VirtualKeyboard extends Sprite {
		
		public function VirtualKeyboard() {
			// takes the asset of the keyboard
			var asset:MovieClip = AssetLoader.getInstance().getAsset("virtualKeyboard");
			this.addChild(asset);
			
			for (var i:uint = 65; i < 91; i++) { // from ascii 65 ('A') to 90 ('Z') it creates keys
				var letter:String = String.fromCharCode(i);
				var key:Key = new Key(asset["letter_" + letter]);
				key.setKeyText(letter);
				key.addEventListener(CustomEvents.CLICK_ON_BUTTON, onKeyClickHandler);
			}
		}
		
		/*
		 * if key is clicked 
		 */
		private function onKeyClickHandler(e:CustomEvents):void {
			trace((e.currentTarget as Key).letter);
			this.dispatchEvent(new CustomEvents(CustomEvents.LETTER_CLICKED, { letter:(e.currentTarget as Key).letter} ));
		}
		
	}

}