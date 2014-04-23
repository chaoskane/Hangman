package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	/**
	 * base menu button
	 * @author Christian Krebs
	 */
	public class MenuButton extends Sprite {
		
		private var asset:MovieClip;
		
		public function MenuButton(assetName:String = "PlayButton") {
			asset = AssetLoader.getInstance().getAsset(assetName);
			this.addChild(asset);
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseEventHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseEventHandler);
			this.addEventListener(MouseEvent.CLICK, onMouseEventHandler);	
		}
		
		/**
		 * on mouse event
		 * @param	e
		 */
		public function onMouseEventHandler(e:MouseEvent):void {
			switch(e.type) {
				case MouseEvent.MOUSE_OVER:														
					var myGlow:GlowFilter = new GlowFilter(); 
					myGlow.inner=true; 
					myGlow.color = 0xF4FA58; 
					myGlow.blurX = 10; 
					myGlow.blurY = 10;
					this.filters = [myGlow];
					break;
				case MouseEvent.MOUSE_OUT:														
					this.filters = [];		
					break;
				case MouseEvent.CLICK:														
					this.dispatchEvent(new CustomEvents(CustomEvents.CLICK_ON_BUTTON));		
					break;
				default:
					trace("mouse event not handled: " + e.type);		
			}
		}
		
	}

}