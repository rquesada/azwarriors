package
{

	import com.azwarriors.controller.FotoGuerreroController;
	import com.azwarriors.controller.FotosConvencionController;
	import com.azwarriors.events.MenuEve;
	import com.azwarriors.footer.FooterView;
	import com.azwarriors.view.Scroll;
	import com.view.VideoConvencionView;
	
	import dev.home.AZwarriorAnimation;
	import dev.home.Background;
	import dev.home.ButtonFotoGuerrero;
	import dev.home.FotoConvencion;
	import dev.home.videosConvencion;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.profiler.showRedrawRegions;

	
	[SWF (backgroundColor='#f4d7b3',  frameRate='30', width='1000', height='715') ]
	public class AZWarriors extends Sprite
	{
		
		private var mainBackground: Background;
		private var fotoGuerreroButton: ButtonFotoGuerrero;
		private var videosConvencionButton: videosConvencion;
		private var fotoConvencionButton:FotoConvencion;
		private var videoConvencionButton: videosConvencion;
		private var introAnimation: AZwarriorAnimation;
		private var fotosConvecionController:FotosConvencionController;
		private var fotoGuerreroController:FotoGuerreroController;
		private var footerView:FooterView;
		
		//View
		private var videoConvencionView:VideoConvencionView;
		
		public function AZWarriors()
		{
			create();	
			show(true);
		}
		
		private function show(shouldBeHide:Boolean):void{
			if(shouldBeHide){
				addChild(introAnimation);
				addChild(fotoGuerreroButton); 
				addChild(fotoConvencionButton);
				addChild(videoConvencionButton); 
				introAnimation.gotoAndPlay(1);
				if(this.contains(footerView))
					removeChild(footerView);
				
			}else{
				removeChild(fotoGuerreroButton); 
				removeChild(fotoConvencionButton);
				removeChild(videoConvencionButton);
				removeChild(introAnimation);
				addChild(footerView);
			}
		}
		private function create():void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//Background
			mainBackground = new Background();
			addChild(mainBackground);
			
			//Button Foto Guerrero
			fotoGuerreroButton = new ButtonFotoGuerrero();
			fotoGuerreroButton.x = 170;
			fotoGuerreroButton.y = 570;
			fotoGuerreroButton.buttonMode = true;
			fotoGuerreroButton.addEventListener(MouseEvent.ROLL_OVER,fgchangeRollOverHandler);
			fotoGuerreroButton.addEventListener(MouseEvent.ROLL_OUT, fgchangeRollOutHandler);
			fotoGuerreroButton.addEventListener(MouseEvent.CLICK, fgchangeClickHandler);
			fotoGuerreroController = new FotoGuerreroController();
			
			
			//Button Foto Convencion
			fotoConvencionButton = new FotoConvencion();
			fotoConvencionButton.x = 520;
			fotoConvencionButton.y = 570;
			fotoConvencionButton.buttonMode = true;
			fotoConvencionButton.addEventListener(MouseEvent.ROLL_OVER,fcChangeRollOverHandler);
			fotoConvencionButton.addEventListener(MouseEvent.ROLL_OUT, fcChangeRollOutHandler);
			fotoConvencionButton.addEventListener(MouseEvent.CLICK, fcChangeClickHandler);
			 
			
			//Button Video Convencion
			videoConvencionButton = new videosConvencion();
			videoConvencionButton.x = 870;
			videoConvencionButton.y = 570;
			videoConvencionButton.buttonMode = true;
			videoConvencionButton.addEventListener(MouseEvent.ROLL_OVER,vcChangeRollOverHandler);
			videoConvencionButton.addEventListener(MouseEvent.ROLL_OUT, vcChangeRollOutHandler);
			videoConvencionButton.addEventListener(MouseEvent.CLICK, vcChangeClickHandler);
			
			//videoConvencionView
			videoConvencionView = new VideoConvencionView();
			videoConvencionView.x =0;
			videoConvencionView.y =0;
			
			//Animation
			introAnimation = new AZwarriorAnimation();
			introAnimation.x=500;
			introAnimation.y= 250;
			
			//Main Menu
			footerView = new FooterView();
			footerView.x=0;
			footerView.y= 715 - 143;
			footerView.addEventListener("goInicio", goInicioHandler);
			footerView.addEventListener("goGuerrero", goGuerreroHandler);
			footerView.addEventListener("goGaleria", goGaleriaHandler);
			footerView.addEventListener("goVideos", goVideosHandler);
			
		}
		//Menu events
		private function goInicioHandler(event:MenuEve):void{
			show(true);
		}
		private function goGuerreroHandler(event:MenuEve):void{
			
		}
		private function goGaleriaHandler(event:MenuEve):void{
			
		}
		private function goVideosHandler(event:MenuEve):void{
			
		}

		//Button Foto Guerrero
		private function fgchangeRollOverHandler(event:MouseEvent):void{
			fotoGuerreroButton.gotoAndPlay(2);
		}
		
		private function fgchangeRollOutHandler(event:MouseEvent):void{
			fotoGuerreroButton.gotoAndPlay(1);
		}
		
		private function fgchangeClickHandler(event:MouseEvent):void{
			trace("Click foto guerrero");
			addChild(fotoGuerreroController.view);
			fotoGuerreroController.init();
			show(false);

		}

		//Button Foto Convencion
		private function fcChangeRollOverHandler(event:MouseEvent):void{
			fotoConvencionButton.gotoAndPlay(2);

		}
		
		private function fcChangeRollOutHandler(event:MouseEvent):void{
			fotoConvencionButton.gotoAndPlay(1);
		}
		
		private function fcChangeClickHandler(event:MouseEvent):void{
			show(false);
			fotosConvecionController = new FotosConvencionController();
			addChild(fotosConvecionController.view);
			fotosConvecionController.init();
			
			
		}
		
		//Button Video Convencion
		private function vcChangeRollOverHandler(event:MouseEvent):void{
			videoConvencionButton.gotoAndPlay(2);
		}
		
		private function vcChangeRollOutHandler(event:MouseEvent):void{
			videoConvencionButton.gotoAndPlay(1);
		}
		
		private function vcChangeClickHandler(event:MouseEvent):void{
			trace("Click video convencion");
			show(false);
			addChild(videoConvencionView);
		}
		
	}
}