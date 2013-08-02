package com.view
{
	import dev.videos.title;
	
	import flash.display.Sprite;
	
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
			addChild(mainTitle);
		}
	}
}