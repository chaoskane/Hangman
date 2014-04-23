package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * this manager handles the different game states
	 * @author Christian Krebs
	 */
	public class GameManager extends Sprite {
		private static var instance:GameManager;	// instance of this singleton class
		
		private var _state:Sprite;
		private var _currentState:uint;
		
		private var _wonsCount:uint;
		private var _lostCount:uint;
		
		private var _resultTextfields:MovieClip;
		
		public static const STATE_MENU:uint = 1;
		public static const STATE_GAME:uint = 2;
		public static const STATE_WIN:uint = 3;
		public static const STATE_LOOSE:uint = 4;
		
		/**
		* Constructor. This class is a singleton and this Constructor shouldn´t be call it. use instead the function getInstance(). 
		**/
		public function GameManager(caller:Function = null) {
			if( caller != GameManager.getInstance ){
				throw new Error ("GameManager is a singleton class, use getInstance() instead");
			}
            if ( GameManager.instance != null ) {
				throw new Error( "Only one GameManager instance should be instantiated" );
			}
		}
		
		/**
		* get the instance of the singleton. In the case of no instance has been initialized,
		* the function call the constructor und return the new instance.
		* @return GameManager instance of the singleton
		**/
		public static function getInstance():GameManager {
			if (instance == null){
				instance = new GameManager(arguments.callee);
			}
			return instance;
		}
		
		/*
		 * - initialize the base of the game which is shown all the time
		 * - sets current state to the Menu State
		 */
		public function init() {
			var background:Bitmap = AssetLoader.getInstance().getBitmap("background");
			this.addChild(background);
			
			var hangmanGameTextImage:Bitmap = AssetLoader.getInstance().getBitmap("hangman_game_text");
			hangmanGameTextImage.x = hangmanGameTextImage.y = 16;
			this.addChild(hangmanGameTextImage);
			
			_resultTextfields = AssetLoader.getInstance().getAsset("resultTextfields");
			_resultTextfields.x = 105;
			_resultTextfields.y = 425;
			this.addChild(_resultTextfields);
			
			wonsCount = lostCount = 0;
			
			_currentState = 0;
			currentState = STATE_MENU;
		}
		
		/*
		 * sets the current state and switches from the current to the new one
		 */
		public function set currentState(value:uint):void {
			if (value != _currentState) {
				_currentState = value;
				switch(_currentState) {
					case STATE_MENU:
						_state = new Menu();
						this.addChild(_state);
						break;
					case STATE_GAME:
						(_state as Menu).destroy();
						this.removeChild(_state);
						_state = new Game();
						this.addChild(_state);
						break;
					case STATE_WIN:
						SoundSystem.getInstance().playSound(SoundSystem.SOUND_WIN, 100);
						onWin();
						break;
					case STATE_LOOSE:
						SoundSystem.getInstance().playSound(SoundSystem.SOUND_LOSE, 100);
						onLose();
						break;
				}
			}
		}
		
		/*
		 * called if the win state is reached
		 */
		private function onWin():void {
			var congrats:Bitmap = AssetLoader.getInstance().getBitmap("congrats");
			congrats.x = 23;
			congrats.y = 164;
			congrats.name = "congrats";
			this.addChild(congrats);
			
			this.stage.addEventListener(MouseEvent.CLICK, onClickAfterFinished);
		}
		
		/*
		 * called if the loose state is reached
		 */
		private function onLose():void {
			this.stage.addEventListener(MouseEvent.CLICK, onClickAfterFinished);
		}
		
		/*
		 * called if user clicked on stage after win/loose the game
		 */
		private function onClickAfterFinished(e:MouseEvent):void {
			this.stage.removeEventListener(MouseEvent.CLICK, onClickAfterFinished);
			if (_currentState == STATE_WIN) {
				this.removeChild(this.getChildByName("congrats"));
				(_state as Game).destroy();
				this.removeChild(_state);
			}else if (_currentState == STATE_LOOSE) {
				(_state as Game).destroy();
				this.removeChild(_state);
			}
			currentState = STATE_MENU;
		}
		
		public function set wonsCount(value:uint):void {
			_wonsCount = value;
			_resultTextfields.wonText.text = String(_wonsCount);
		}
		
		public function set lostCount(value:uint):void {
			_lostCount = value;
			_resultTextfields.lostText.text = String(_lostCount);
		}
		
		public function get wonsCount():uint {
			return _wonsCount;
		}
		
		public function get lostCount():uint {
			return _lostCount;
		}
		
	}

}