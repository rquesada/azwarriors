package com.azwarriors.view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	public class FotoConvencionThumbView extends Sprite
	{
		public static const EVENT_THUMB_CLICK:String = "onThumbClick";
		
		private var thumbImage:Bitmap;
		private var frame:Sprite;
		private var border:Sprite;
		private var borderSelected:Sprite;
		
		public function FotoConvencionThumbView(image:Bitmap)
		{
			frame = new Sprite();
			frame.graphics.beginFill(0xCFBAA0,0.75);
			frame.graphics.drawRect(0,0,153,103);
			frame.graphics.endFill();
			addChild(frame);
			
			border = new Sprite();
			border.graphics.lineStyle(3,0x791A4E);
			border.graphics.beginFill(0x000000, 0);
			border.graphics.drawRect(0, 0, 153, 103);
			border.graphics.endFill();
			//addChild(border);
			
			
			borderSelected = new Sprite();
			borderSelected.graphics.lineStyle(3,0xE85A29);
			borderSelected.graphics.beginFill(0x000000, 0);
			borderSelected.graphics.drawRect(0, 0, 153, 103);
			borderSelected.graphics.endFill();
			
			
			thumbImage = image;
			thumbImage.x = 8;
			thumbImage.y = 8;
			addChild(thumbImage);
			
			addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
			addEventListener(MouseEvent.CLICK, onClickHandler);
			//var dropShadow : DropShadowFilter = new DropShadowFilter(10,45,0,0.5,10,10,1,1);
			//filters = [dropShadow];
		}
		
		private function onRollOverHandler(event:MouseEvent):void{
			addChild(border);
		}
		
		private function onRollOutHandler(event:MouseEvent):void{
			removeChild(border);
		}
		
		private function onClickHandler(event:MouseEvent):void{
			dispatchEvent(new Event(EVENT_THUMB_CLICK));
		}
		
		public function selectThumb():void{
			if(!contains(borderSelected)) {
				addChild(borderSelected);
			}
		}
		
		public function deSelectThumb():void{
			if(contains(borderSelected)){
				removeChild(borderSelected);
			}
		}
		
	}
}