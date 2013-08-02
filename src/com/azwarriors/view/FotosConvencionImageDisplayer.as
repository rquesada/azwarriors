package com.azwarriors.view
{
	import com.azwarriors.assets.arrowBtn_FC;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	public class FotosConvencionImageDisplayer extends Sprite
	{
		private var arrowBtnRight:arrowBtn_FC;
		private var arrowBtnLeft:arrowBtn_FC;
		
		private var image:Bitmap;
		
		public function FotosConvencionImageDisplayer()
		{
			init();
		}
		
		public function init():void{
			arrowBtnRight = new arrowBtn_FC();
			
			
			arrowBtnLeft = new arrowBtn_FC();
			arrowBtnLeft.scaleX = -1;
			arrowBtnLeft.x = arrowBtnLeft.width;
			arrowBtnLeft.y = 154;//(302/2) - (arrowBtnLeft.height/2);
			
			image = new Bitmap();
			image.x = arrowBtnLeft.width + 20;
			image.smoothing = true;
			
			var dropShadow : DropShadowFilter = new DropShadowFilter(10,45,0,0.5,10,10,1,1);
			
			image.filters = [dropShadow];
			
			arrowBtnRight.x = image.x + 502 + 20;
			arrowBtnRight.y = arrowBtnLeft.y;
			addChild(image);
			addChild(arrowBtnRight);
			addChild(arrowBtnLeft);
		}
		
		public function presentImage(_image:Bitmap):void{
			image.bitmapData = _image.bitmapData;
		}
	}
}