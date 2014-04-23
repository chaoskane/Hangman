package {
	import flash.events.Event;
	
	/**
	 * CustomEvents gave us the possibility for own events depending on our game, if 
	 * the game gets bigger, we can differ between types (e.g we have TimeEvents, GameEvents, ...)
	 * @author Christian Krebs
	 */
	public class CustomEvents extends Event{
		/** Event-related data which varies based on the type of event. **/
		public var data:*;
		
		/** clicking on a button**/
		public static const CLICK_ON_BUTTON:String 					= "clickOnButtonEvent";
		
		public static const LETTER_CLICKED:String					= "letterClicked";
		
		public static const WORD_FINISHED:String					= "wordFinished";
		
		public static const GALLOW_COMPLETE:String					= "gallowComplete";
		
		/**
		 * constructor
		 * @param	_type event type
		 * @param	_data event data
		 */
		public function CustomEvents(_type:String, _data:*=null){
			super(_type, false, false);
			this.data=_data;
		}
		
		/** @inheritDoc **/
		public override function clone():Event{
			return new CustomEvents(this.type, this.data);
		}
		
	}

}