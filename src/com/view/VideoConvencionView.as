package com.view
{
	import com.azwarriors.view.Scroll;
	import com.azwarriors.view.VideoViewContainer;
	import flash.display.Sprite;
	
	
	public class VideoConvencionView extends Sprite
	{
		private var scroll:Scroll;
		public var view:VideoViewContainer;
		
		
		public function VideoConvencionView()
		{
			super();
			create();
		}
		
		private function create():void{
			
			//Container
			view = new VideoViewContainer();
			//Scroll
			scroll = new Scroll();
			scroll.init(910, 500, view);	
			addChild(scroll);
			scroll.x = 40;
			scroll.y = 40;
	
		}
	}
}