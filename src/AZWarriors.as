package
{

	import com.azwarriors.assets.btnInicio_FC;
	import com.azwarriors.assets.mcCloseBtn_FC;
	import com.azwarriors.assets.mcPauseButton_FC;
	import com.azwarriors.assets.mcPlayButton_FC;
	import com.azwarriors.controller.FotoGuerreroController;
	import com.azwarriors.controller.FotosConvencionController;
	import com.azwarriors.controller.GaleriaController;
	import com.azwarriors.events.MenuEve;
	import com.azwarriors.footer.FooterView;
	import com.azwarriors.model.MainModel;
	import com.azwarriors.view.Scroll;
	import com.greensock.layout.ScaleMode;
	import com.view.VideoConvencionView;
	
	import dev.home.AZwarriorAnimation;
	import dev.home.AZwarriorAnimation2;
	import dev.home.Background;
	import dev.home.ButtonFotoGuerrero;
	import dev.home.FotoConvencion;
	import dev.home.videosConvencion;
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.profiler.showRedrawRegions;
	import flash.system.fscommand;
	

	
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
		private var closeBtn:mcCloseBtn_FC;
		private var videoConvencionView:VideoConvencionView;
		private var inicioBtn:btnInicio_FC;
		
		private var pauseBtn:mcPauseButton_FC;
		private var playBtn:mcPlayButton_FC;
		private var pausePoint:Number;
		private var isPlaying:Boolean;
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		
		public function AzFlash()
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
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreenEventHandler);
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
			//				videoConvencionView = new VideoConvencionView();
			//				videoConvencionView.x =0;
			//				videoConvencionView.y =0;
			
			//Galeria
			//				fotosConvecionController = new FotosConvencionController();
			//				fotosConvecionController.init();
			
			//Foto Guerrero
			//				galeriaController = new GaleriaController();
			//				galeriaController.view.init();
			
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
			
			closeBtn = new mcCloseBtn_FC();
			closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnMouseClick);
			
			//
			soundChannel = new SoundChannel();
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE, onSoundComplete);
			sound.load(new URLRequest("sounds/fotoGuerrero/Daddy_Yankee_Limbo.mp3"));
			
			playBtn = new mcPlayButton_FC();
			playBtn.addEventListener(MouseEvent.CLICK, onPlayClickHandler);
			playBtn.y = playBtn.height;
			playBtn.x = 110;
			playBtn.buttonMode = true;
			
			pauseBtn = new mcPauseButton_FC();
			pauseBtn.buttonMode=true;
			pauseBtn.addEventListener(MouseEvent.CLICK, onPauseClickHandler);
			pauseBtn.y = playBtn.y;
			pauseBtn.x = playBtn.x + playBtn.width - 20;
			
			addChild(playBtn);
			addChild(pauseBtn);
		}
		
		private function onPauseClickHandler(event:MouseEvent):void {
			if(isPlaying){
				pausePoint = soundChannel.position;
				soundChannel.stop();
				isPlaying = false;
			}
		}
		
		private function onPlayClickHandler(event:MouseEvent):void {
			if(!isPlaying){
				soundChannel = sound.play(pausePoint);
				isPlaying= true;
			}
			
		}
		
		private function onSoundComplete(event:Event):void {
			soundChannel = sound.play();
			isPlaying = true;
		}
		
		private function onCloseBtnMouseClick(event : MouseEvent) : void {
			stage.displayState = StageDisplayState.NORMAL;
			//fscommand("quit");
		}
		
		private function addedToStageHandler(event : Event) : void {
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreenEventHandler);
		}
		
		private function onFullScreenEventHandler(event : FullScreenEvent) : void {
			if(!contains(closeBtn)){
				
				addChild(closeBtn);
			}else{
				
				removeChild(closeBtn);
			}
		}
		
		private function hideLastView():void{
			if(lastView == inicioView){
				show(false);
			}else if (lastView == guerreroView){
				//fotoGuerreroController.stopView();
				//removeChild(fotoGuerreroController.view);
				//removeChild(galeriaController.view);
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
			
			if(galeriaController == null){
				galeriaController = new GaleriaController();
				galeriaController.view.init();
			}
			
			
			hideLastView();
			addChild(galeriaController.view);
			galeriaController.view.x = 0;
			inicioBtn = new btnInicio_FC();
			inicioBtn.buttonMode=true;
			addChild(inicioBtn);
			inicioBtn.addEventListener(MouseEvent.CLICK, onBtnInicio);
			inicioBtn.x = 850;
			inicioBtn.y = 60;
			lastView= guerreroView;
			addChild(playBtn);
			addChild(pauseBtn);
		}
		
		private function onBtnInicio(event : MouseEvent) : void {
			removeChild(inicioBtn);
			try{
				galeriaController.view.x = stage.stageWidth + 10000;
			}catch(e:Error){
			}
			show(true);
		}
		
		private function goGaleriaHandler(event:MenuEve):void{
			if(fotosConvecionController==null){
				fotosConvecionController = new FotosConvencionController();
				fotosConvecionController.init();
			}
			
			hideLastView();
			addChild(fotosConvecionController.view);
			lastView = galeriaView;
		}
		private function goVideosHandler(event:MenuEve):void{
			if(videoConvencionView==null){
				videoConvencionView = new VideoConvencionView();
				videoConvencionView.x =0;
				videoConvencionView.y =0;
			}
			
			
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