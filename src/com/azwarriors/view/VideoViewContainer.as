package com.azwarriors.view
{
	import com.greensock.TweenNano;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.VideoLoader;
	import com.util.PlayPauseBtn;
	
	import dev.home.harlemTitle;
	import dev.videos.convecionTitle;
	import dev.videos.title;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Video;
	
	public class VideoViewContainer extends Sprite
	{
		private var mainTitle:title;
		private var vid1:VideoLoader;
		private var vid2:VideoLoader;
		private var btn1:PlayPauseBtn;
		private var btn2:PlayPauseBtn;
		private var rollArea1:Sprite;
		private var rollArea2:Sprite;
		
//		MAC
		private var url1:String = './videos/video2.flv';
		private var url2:String = './videos/video1.flv';
		
		
//		PC
//		private var url1:String = 'videos\\video2.flv';
//		private var url2:String = 'videos\\video1.flv';
		
		public function VideoViewContainer()
		{
			super();
			create();
		}
		
		private function create():void{
			//Main title
			mainTitle = new title();
			mainTitle.x = 172;
			addChild(mainTitle);
			
			
			//Video 1
			var widthVideo1:int = 555;
			var heighVideo1:int = 312;
			var xVideo1:int =(1000-widthVideo1)/2;
			var yVideo1:int = 120;
			
			vid1 = new VideoLoader(url1, { name:"myVideo", container:this, width:widthVideo1,x:xVideo1, y:yVideo1,height:heighVideo1, scaleMode:"proportionalInside", autoPlay:false} );
			vid1.addEventListener(VideoLoader.VIDEO_COMPLETE, vidCompleteHandler1);
			vid1.load();
			
			rollArea1 = new Sprite();
			rollArea1.graphics.beginFill(0x000000,0);
			rollArea1.graphics.drawRect(xVideo1, yVideo1, widthVideo1, heighVideo1);
			rollArea1.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler1);
			rollArea1.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler1);
			rollArea1.graphics.endFill();
			addChild(rollArea1);
			
			btn1 = new PlayPauseBtn();
			btn1.buttonMode = true;
			btn1.x = 1000 / 2 - btn1.width/2;
			btn1.y = yVideo1 + heighVideo1/2 -  btn1.height / 2;
			
			btn1.addEventListener(MouseEvent.CLICK, btnClicked1);
			rollArea1.addChild(btn1);
			
			//Video 2
			var widthVideo2:int = 555;
			var heighVideo2:int = 312;
			var xVideo2:int =(1000-widthVideo2)/2;
			var yVideo2:int = 500;
			
			vid2 = new VideoLoader(url2, { name:"myVideo2", container:this, width:widthVideo2,x:xVideo2, y:yVideo2,height:heighVideo2, scaleMode:"proportionalInside", autoPlay:false} );
			vid2.addEventListener(VideoLoader.VIDEO_COMPLETE, vidCompleteHandler2);
			vid2.load();
			
			rollArea2 = new Sprite();
			rollArea2.graphics.beginFill(0x000000,0);
			rollArea2.graphics.drawRect(xVideo2, yVideo2, widthVideo2, heighVideo2);
			rollArea2.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler2);
			rollArea2.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler2);
			rollArea2.graphics.endFill();
			addChild(rollArea2);
			
			btn2 = new PlayPauseBtn();
			btn2.buttonMode = true;	
			btn2.x = 1000 / 2 - btn2.width/2;
			btn2.y = yVideo2 + heighVideo2/2 -  btn2.height / 2;
			
			btn2.addEventListener(MouseEvent.CLICK, btnClicked2);
			rollArea2.addChild(btn2);
			
			
			//Title 1
			var video1Title:harlemTitle = new harlemTitle();
			video1Title.x = (1000 - video1Title.width)/2;
			video1Title.y = 70;
			addChild(video1Title);
			
			//Title 1
			var video2Title:convecionTitle = new convecionTitle();
			video2Title.x = (1020 - video2Title.width)/2;
			video2Title.y = 450;
			addChild(video2Title);
		}
		
		public function stopView():void{
			if(!vid1.videoPaused){
				vid1.videoPaused = true;
				btn1.clicked();
			}
			
			if(!vid2.videoPaused){
				vid2.videoPaused = true;
				btn2.clicked();
			}
			
		}
		
		// Video 1 Event Handler
		private function mouseHandler1(e:MouseEvent):void 
		{
			if (e.type == "mouseOver")TweenNano.to(btn1, 0.5, { alpha:1 } );
			if (e.type == "mouseOut") TweenNano.to(btn1, 0.5, { alpha:0 } );
		}
		
		private function btnClicked1(e:MouseEvent):void 
		{
			vid1.videoPaused = !vid1.videoPaused;
		}
		
		private function vidCompleteHandler1(e:Event):void 
		{
			vid1.gotoVideoTime(0);
			btn1.clicked();
		}
		
		
		// Video 2 Event Handler
		private function mouseHandler2(e:MouseEvent):void 
		{
			if (e.type == "mouseOver")TweenNano.to(btn2, 0.5, { alpha:1 } );
			if (e.type == "mouseOut") TweenNano.to(btn2, 0.5, { alpha:0 } );
		}
		
		private function btnClicked2(e:MouseEvent):void 
		{
			vid2.videoPaused = !vid2.videoPaused;
		}
		
		private function vidCompleteHandler2(e:Event):void 
		{
			vid2.gotoVideoTime(0);
			btn2.clicked();
		}
	}
}