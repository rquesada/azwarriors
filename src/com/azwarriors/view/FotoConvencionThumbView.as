package com.azwarriors.view
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	public class FotoConvencionThumbView extends Sprite
	{
		private var thumbImage:Bitmap;
		public function FotoConvencionThumbView(image:Bitmap)
		{
			thumbImage = image;
			addChild(thumbImage);
			
			var dropShadow : DropShadowFilter = new DropShadowFilter(10,45,0,0.5,10,10,1,1);
			
			filters = [dropShadow];
		}
	}
}