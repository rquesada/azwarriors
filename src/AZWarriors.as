package
{
	import dev.home.Background;
	import dev.home.ButtonFotoGuerrero;
	
	import flash.display.Sprite;
	
	[SWF (backgroundColor='#f4d7b3',  frameRate='30', width='1000', height='600') ]
	public class AZWarriors extends Sprite
	{
		
		private var mainBackground: Background;
		private var fotoGuerreroButton: ButtonFotoGuerrero;
		
		public function AZWarriors()
		{
			create();	
		}
		
		private function create():void{
			
			//Background
			mainBackground = new Background();
			addChild(mainBackground);
			
			//Button Foto Guerrero
			fotoGuerreroButton = new ButtonFotoGuerrero();
			addChild(fotoGuerreroButton); 
			
		}
	}
}