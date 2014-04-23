package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * creates the gallow which updates after making a mistake
	 * @author Christian Krebs
	 */
	public class Gallow extends Sprite {
		
		private var _gallow:MovieClip;
		private var _amountMistakes:uint;
		
		public function Gallow() {
			_gallow = AssetLoader.getInstance().getAsset("gallow");
			amountMistakes = 0;
			this.addChild(_gallow);
		}
		
		public function get amountMistakes():uint {
			return _amountMistakes;
		}
		
		public function set amountMistakes(value:uint):void {
			_amountMistakes = value;
			
			for (var i:uint = 0; i < _gallow.numChildren; i++) {
				if (i < _amountMistakes) {
					_gallow.getChildAt(i).visible = true;
				}else {
					_gallow.getChildAt(i).visible = false;
				}
				
			}
			
			if (_amountMistakes == _gallow.numChildren) { // dispatch event if gallow is complete
				this.dispatchEvent(new CustomEvents(CustomEvents.GALLOW_COMPLETE));
			}
		}
		
	}

}