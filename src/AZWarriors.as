package
{

	import com.azwarriors.model.MainModel;
	import com.greensock.layout.ScaleMode;
	import com.azwarriors.controller.FotoGuerreroController;
	import com.azwarriors.controller.FotosConvencionController;
	import com.azwarriors.controller.GaleriaController;
	import com.azwarriors.events.MenuEve;
	import com.azwarriors.footer.FooterView;
	import com.azwarriors.view.Scroll;
	import com.view.VideoConvencionView;
	
	import dev.home.AZwarriorAnimation;
	import dev.home.AZwarriorAnimation2;
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
		private var introAnimation: AZwarriorAnimation2;
		private var fotosConvecionController:FotosConvencionController;
		private var fotoGuerreroController:FotoGuerreroController;
		private var footerView:FooterView;
		
		private var lastView:String;
		private var inicioView:String = "inicioView";
		private var guerreroView:String = "guerreroView";
		private var galeriaView:String = "galeriaView";
		private var videosView:String = "videosView";
		private var galeriaController:GaleriaController;
		
		//View
		private var videoConvencionView:VideoConvencionView;
		
		public function AZWarriors()
		{
			//stage.scaleMode = StageScaleMode.EXACT_FIT;
			
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
				
				lastView = inicioView;
				
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
			
			MainModel.getInstance().half_height = (stage.stageHeight/2);
			MainModel.getInstance().half_width = (stage.stageWidth/2);
			
			MainModel.getInstance().modalWidth = stage.stageWidth;
			MainModel.getInstance().modalHeight = stage.stageHeight;
			MainModel.getInstance().modalX = 0;
			MainModel.getInstance().modalY = 0;
			
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
			
			//Galeria
			fotosConvecionController = new FotosConvencionController();
			fotosConvecionController.init();
			
			//Foto Guerrero
//			fotoGuerreroController = new FotoGuerreroController();
			galeriaController = new GaleriaController();
			//addChild(galeriaController.view)
			galeriaController.view.init();
			
			//Animation
			introAnimation = new AZwarriorAnimation2();
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
		
		private function hideLastView():void{
			if(lastView == inicioView){
				show(false);
			}else if (lastView == guerreroView){
				//fotoGuerreroController.stopView();
				//removeChild(fotoGuerreroController.view);
				removeChild(galeriaController.view);
			}else if(lastView == galeriaView){
				removeChild(fotosConvecionController.view);
			}else if (lastView == videosView){
				videoConvencionView.view.stopView();
				removeChild(videoConvencionView);
			}
		}
		
		//Menu events
		private function goInicioHandler(event:MenuEve):void{
			hideLastView();
			show(true);
			
		}
		private function goGuerreroHandler(event:MenuEve):void{
			hideLastView();
//			fotoGuerreroController = new FotoGuerreroController();
//			fotoGuerreroController.init();
//			addChild(fotoGuerreroController.view);
			addChild(galeriaController.view);
			//galeriaController.view.height = 2500;
			
			lastView= guerreroView;
		}
		private function goGaleriaHandler(event:MenuEve):void{
			hideLastView();
			addChild(fotosConvecionController.view);
			lastView = galeriaView;
		}
		private function goVideosHandler(event:MenuEve):void{
			hideLastView();
			addChild(videoConvencionView);
			lastView = videosView;
		}

		//Button Foto Guerrero
		private function fgchangeRollOverHandler(event:MouseEvent):void{
			fotoGuerreroButton.gotoAndPlay(2);
		}
		
		private function fgchangeRollOutHandler(event:MouseEvent):void{
			fotoGuerreroButton.gotoAndPlay(1);
		}
		
		private function fgchangeClickHandler(event:MouseEvent):void{
			goGuerreroHandler(null);
		}

		//Button Foto Convencion
		private function fcChangeRollOverHandler(event:MouseEvent):void{
			fotoConvencionButton.gotoAndPlay(2);
		}
		
		private function fcChangeRollOutHandler(event:MouseEvent):void{
			fotoConvencionButton.gotoAndPlay(1);
		}
		
		private function fcChangeClickHandler(event:MouseEvent):void{
			goGaleriaHandler(null);
		}
		
		//Button Video Convencion
		private function vcChangeRollOverHandler(event:MouseEvent):void{
			videoConvencionButton.gotoAndPlay(2);
		}
		
		private function vcChangeRollOutHandler(event:MouseEvent):void{
			videoConvencionButton.gotoAndPlay(1);
		}
		
		private function vcChangeClickHandler(event:MouseEvent):void{
			goVideosHandler(null);
		}
		
	}
}