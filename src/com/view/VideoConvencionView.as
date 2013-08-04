package com.view
{
	import dev.videos.title;
	
	import flash.display.Sprite;
	import flash.media.Video;
	
	
	public class VideoConvencionView extends Sprite
	{
		private var mainTitle:title;
		
		public function VideoConvencionView()
		{
			super();
			create();
		}
		
		private function create():void{
			mainTitle = new title();
			mainTitle.x = 172;
			addChild(mainTitle);
	
		}
	}
}