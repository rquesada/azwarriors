package com.azwarriors.view
{
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	public class GaleriaView extends Sprite
	{
		private var mLoader:Loader
		public function GaleriaView()
		{
			
		}
		
		public function init():void{
			mLoader = new Loader();
			var mRequest:URLRequest = new URLRequest("./galeria/index.swf");
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			mLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			mLoader.load(mRequest);
		}
		
		private function onProgressHandler(mProgress:ProgressEvent)
		{
			var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
			trace(percent);
		}
		
		private function  onCompleteHandler(loadEvent:Event):void
		{
			addChild(mLoader);
		}

		public function remove():void{
			parent.removeChild(this);
		}
	}
}