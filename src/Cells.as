package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * guessed cells block
	 * @author Christian Krebs
	 */
	public class Cells extends Sprite {
		
		private var _cells:Array;		// array of cell mc for later access
		
		public function Cells(searchedWord:String) {
			_cells = new Array();
			for (var i:uint = 0; i < searchedWord.length; i++) {
				var cell:MovieClip = AssetLoader.getInstance().getAsset("guessCell");
				cell.x = ((i*cell.width) + (i*5));
				cell.alpha = 0.75;
				cell.guessedLetter.text = searchedWord.charAt(i);
				cell.guessedLetter.visible = false;
				this.addChild(cell);
				_cells.push(cell);
			}
		}
		
		/*
		 * shows letter by cell id 
		 */
		public function showLetter(id:uint):void {
			_cells[id].guessedLetter.visible = true;
			var numActivatedCells:uint = 0;
			for (var i:uint = 0; i < _cells.length; i++) {
				if (_cells[i].guessedLetter.visible) {
					numActivatedCells += 1;
				}
			}
			
			if (numActivatedCells == _cells.length) { // dispatches event if word is finished
				this.dispatchEvent(new CustomEvents(CustomEvents.WORD_FINISHED));
			}
			
		}
		
	}

}