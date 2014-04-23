package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * game menu state
	 * @author Christian Krebs
	 */
	public class Menu extends Sprite {
		
		public function Menu() {
			// creates rule box image
			var rulesBox:Bitmap = AssetLoader.getInstance().getBitmap("rulesBox");
			rulesBox.x = 15.5;
			rulesBox.y = 91;
			this.addChild(rulesBox);
			// creates hangman image
			var hangMan:Bitmap = AssetLoader.getInstance().getBitmap("hangman");
			hangMan.x = 5;
			hangMan.y = 263;
			this.addChild(hangMan);
			// creates play button
			var btn:MenuButton = new MenuButton("PlayButton");
			btn.x = 100;
			btn.y = 320;
			btn.addEventListener(CustomEvents.CLICK_ON_BUTTON, onClickButton);
			this.addChild(btn);
		}
		
		/*
		 * fires if play button is clicked
		 */
		private function onClickButton(e:CustomEvents):void {
			(e.currentTarget as MenuButton).removeEventListener(CustomEvents.CLICK_ON_BUTTON, onClickButton);
			GameManager.getInstance().currentState = GameManager.STATE_GAME;
		}
		
		/*
		 * destroy function which removes menu state content
		 */
		public function destroy() {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
		}
		
	}

}