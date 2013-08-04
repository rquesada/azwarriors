package com.view
{
	import com.greensock.TweenNano;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.VideoLoader;
	import com.util.PlayPauseBtn;
	
	import dev.videos.title;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Video;
	
	
	public class VideoConvencionView extends Sprite
	{
		private var mainTitle:title;
		private var vid:VideoLoader;
		private var btn:PlayPauseBtn;
		private var rollArea:Sprite;
		private var url:String = '/videos/Convencion_RD.flv';
		
		
		public function VideoConvencionView()
		{
			super();
			create();
		}
		
		private function create():void{
			mainTitle = new title();
			mainTitle.x = 172;
			addChild(mainTitle);
			
			//Video 1
			vid = new VideoLoader(url, { name:"myVideo", container:this, width:320, height:20, scaleMode:"proportionalInside", autoPlay:false} );
			vid.addEventListener(VideoLoader.VIDEO_COMPLETE, vidCompleteHandler);
			vid.load();
			
			rollArea = new Sprite();
			rollArea.graphics.beginFill(0x000000,0);
			rollArea.graphics.drawRect(0, 0, 320, 240);
			rollArea.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			rollArea.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
			rollArea.graphics.endFill();
			addChild(rollArea);
			
			btn = new PlayPauseBtn();
			btn.x = 320 / 2 - btn.width / 2;
			btn.y = 260 / 2 - btn.height / 2; 
			btn.addEventListener(MouseEvent.CLICK, btnClicked);
			rollArea.addChild(btn);
			
	
		}
		
		private function mouseHandler(e:MouseEvent):void 
		{
			if (e.type == "mouseOver")TweenNano.to(btn, 0.5, { alpha:1 } );
			if (e.type == "mouseOut") TweenNano.to(btn, 0.5, { alpha:0 } );
		}
		
		private function btnClicked(e:MouseEvent):void 
		{
			vid.videoPaused = !vid.videoPaused;
		}
		
		private function vidCompleteHandler(e:Event):void 
		{
			vid.gotoVideoTime(0);
			btn.clicked();
		}
	}
}