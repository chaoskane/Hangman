package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * the game state
	 * @author Christian Krebs
	 */
	public class Game extends Sprite {
		
		private var _searchedWord:String;
		private var _cells:Cells;
		private var _virtualKeyboard:VirtualKeyboard;
		private var _gallow:Gallow;
		
		public function Game() {
			_searchedWord = XmlParser.getInstance().wordsArray[uint(Math.random() * XmlParser.getInstance().wordsArray.length)];
			// creates gallow
			_gallow = new Gallow();
			_gallow.x = 126;
			_gallow.y = 417;
			this.addChild(_gallow);
			_gallow.addEventListener(CustomEvents.GALLOW_COMPLETE, onGallowCompleteHandler);
			// creates virtual keyboard for user access
			_virtualKeyboard = new VirtualKeyboard();
			_virtualKeyboard.x = 90;
			_virtualKeyboard.y = 310;
			this.addChild(_virtualKeyboard);
			_virtualKeyboard.addEventListener(CustomEvents.LETTER_CLICKED, onLetterClicked);
			// creates hangman image
			var hangMan:Bitmap = AssetLoader.getInstance().getBitmap("hangman");
			hangMan.x = 5;
			hangMan.y = 263;
			this.addChild(hangMan);
			// creates cells for guessed letters
			_cells = new Cells(_searchedWord);
			_cells.x = _cells.width / 2;
			_cells.y = 66;
			_cells.addEventListener(CustomEvents.WORD_FINISHED, onFinishedHandler);
			this.addChild(_cells);
		}
		
		/*
		 * fires if the gallow ist complete (max mistakes reached)
		 */
		private function onGallowCompleteHandler(e:CustomEvents):void {
			_virtualKeyboard.removeEventListener(CustomEvents.LETTER_CLICKED, onLetterClicked);
			GameManager.getInstance().lostCount += 1;
			GameManager.getInstance().currentState = GameManager.STATE_LOOSE;
		}
		
		/*
		 * fires if the the word is complete after guessing letters
		 */
		private function onFinishedHandler(e:CustomEvents):void {
			_cells.removeEventListener(CustomEvents.WORD_FINISHED, onFinishedHandler);
			GameManager.getInstance().wonsCount += 1;
			
			_virtualKeyboard.removeEventListener(CustomEvents.LETTER_CLICKED, onLetterClicked);
			GameManager.getInstance().currentState = GameManager.STATE_WIN;
		}
		
		/*
		 * fires if the user clicked on a letter of the virtual keyboard
		 */
		private function onLetterClicked(e:CustomEvents):void {
			var selectedLetter:String = e.data.letter;
			var index:int = -1;
			var letter_lower:String = selectedLetter.toLowerCase();
			var letterFound:Boolean = false;
			while ( (index = _searchedWord.indexOf(letter_lower, index+1) ) !=-1){
				_cells.showLetter(index);
				letterFound = true;
			}
			if (!letterFound) {
				_gallow.amountMistakes += 1; 
			}
		}
		
		/*
		 * destroy function which removes game state content
		 */
		public function destroy():void {
			_gallow.removeEventListener(CustomEvents.GALLOW_COMPLETE, onGallowCompleteHandler);
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
		}
		
	}

}