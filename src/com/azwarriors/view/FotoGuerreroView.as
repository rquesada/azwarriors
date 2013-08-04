package com.azwarriors.view {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.azwarriors.assets.mcFotoGuerreroTitle;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import com.azwarriors.assets.mcMaskFotoGuerrero_FC;
	import com.greensock.easing.Quint;
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;
	import com.azwarriors.vo.FotoGuerreroItemVO;
	import com.azwarriors.assets.mcArrowBtn_FC;
	import com.azwarriors.vo.FotoGuerreroVO;
	import flash.display.Sprite;

	/**
	 * @author EstebanChavarria
	 */
	public class FotoGuerreroView extends Sprite {
		private var fotoGuerreroVO:FotoGuerreroVO;
		private var mcArrowRight:mcArrowBtn_FC;
		private var mcArrowLeft:mcArrowBtn_FC;
		private var maskContainer:Sprite;
		private var container:Sprite; 
		private var carruselContainer:Sprite;
		private var imagesArray:Array;
		private var currentX:int;
		
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		
		private var currentImage:int;
		
		private var isNextProguess:Boolean;
		private var timer:Timer;
		
		public function FotoGuerreroView(){
		}
		
		public function init(fotoGuerreroVO:FotoGuerreroVO):void {
			this.fotoGuerreroVO = fotoGuerreroVO;
			
			var title:mcFotoGuerreroTitle = new mcFotoGuerreroTitle();
			title.x = (stage.stageWidth / 2) - (title.width/ 2);
			title.y = 50; 
			addChild(title);
			
			maskContainer = new Sprite();
			maskContainer.graphics.beginFill(0xffffff);
			maskContainer.graphics.drawRect(0, 0, 700, 500);
			maskContainer.graphics.endFill();
			
			
			container = new Sprite();
			
			carruselContainer = new Sprite();
			
			soundChannel = new SoundChannel();
			
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE, onSoundComplete);
			sound.load(new URLRequest("sounds/fotoGuerrero/Daddy_Yankee_Limbo.mp3"));
			addGuerreros();
		}
		
		private function addGuerreros():void {
			
			imagesArray = new Array();
			var xPos:int = 0;
			for each(var guerreroVO:FotoGuerreroItemVO in fotoGuerreroVO.fotoGuerrerosArray) {
				
				var imageContainer:Sprite = new Sprite();
				imageContainer.graphics.beginFill(0x000000,0);
				imageContainer.graphics.drawRect(0, 0, maskContainer.width, maskContainer.height);
				
				var xPosImage:Number = 0;
				xPosImage = (maskContainer.width / 2) - (guerreroVO.image.width/2);
				
				var yPosImage:Number = 0;
				yPosImage = (maskContainer.height/ 2) - (guerreroVO.image.height/2);
				
				guerreroVO.image.x = xPosImage;
				guerreroVO.image.y = yPosImage;
				
				guerreroVO.image.smoothing = true;
				
				imageContainer.addChild(guerreroVO.image);
				imageContainer.x = xPos;
				container.addChild(imageContainer);
				imagesArray.push(imageContainer);
				xPos += imageContainer.width + 50;
			}
			
			carruselContainer.addChild(container);
			carruselContainer.addChild(maskContainer);
			container.mask = maskContainer;
			
			carruselContainer.y = 100;
			addChild(carruselContainer);
			
			mcArrowRight = new mcArrowBtn_FC();
			addChild(mcArrowRight);
			
			
			mcArrowLeft = new mcArrowBtn_FC();
			mcArrowLeft.scaleX = -1;
			mcArrowLeft.x += mcArrowLeft.width;   
			
			carruselContainer.x = (stage.stageWidth / 2) - (maskContainer.width/2);
			
			mcArrowRight.addEventListener(MouseEvent.CLICK, onNextImageClick);
			mcArrowLeft.addEventListener(MouseEvent.CLICK, onPreviousImageClick);
			
			mcArrowRight.x = carruselContainer.x + maskContainer.width + mcArrowRight.width + 5;
			mcArrowRight.y = carruselContainer.y + (maskContainer.height / 2) - (mcArrowRight.height/2);
			
			mcArrowLeft.y = mcArrowRight.y;
			
			currentX = 0;
			currentImage = 0;
			addChild(mcArrowRight);
			addChild(mcArrowLeft);
			
			isNextProguess = true;
			timer = new Timer(5000);
			timer.addEventListener(TimerEvent.TIMER, onTimerEvent);
			timer.start();
			
			/*var maskLefth:mcMaskFotoGuerrero_FC = new mcMaskFotoGuerrero_FC();
			addChild(maskLefth);
			maskLefth.x = carruselContainer.x;*/
		}

		private function onNextImageClick(event:MouseEvent):void {
			if(event != null){
				timer.stop();
				timer.start();
			}
			currentImage++;
			currentX -= 750;
			TweenLite.to(container, 2, {x:currentX,ease:Quint.easeOut});
			
			if(currentImage == (imagesArray.length-1)){
				isNextProguess = false;
				removeChild(mcArrowRight);
				//return;
			}else{
				if(!(contains(mcArrowRight))) {
					addChild(mcArrowRight);
				}
			}	
			
			if(!(contains(mcArrowLeft))) {
				addChild(mcArrowLeft);
			}
			
		}

		private function onPreviousImageClick(event:MouseEvent):void{
			if(event != null){
				timer.stop();
				timer.start();
			}
			currentImage--;
			currentX += 750;
			TweenLite.to(container, 2, {x:currentX,ease:Quint.easeOut});	
				
			if(currentImage == 0 ) {
				isNextProguess = true;
				removeChild(mcArrowLeft);
				//return;
			}else{
				if(!contains(mcArrowLeft)){
					addChild(mcArrowLeft);
				}
			}
			
			if(!(contains(mcArrowRight))) {
				addChild(mcArrowRight);
			}
		}
		
		private function onTimerEvent(event:TimerEvent):void{
			if(isNextProguess){
				onNextImageClick(null);
			}else{
				onPreviousImageClick(null);
			}
		}
		
		private function onSoundComplete(event:Event):void {
			soundChannel = sound.play();
		}
		
		public function stopSong():void {
			soundChannel.stop();
		}
	}
}
