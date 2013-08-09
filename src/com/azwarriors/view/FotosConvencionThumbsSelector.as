package com.azwarriors.view
{
	import com.azwarriors.events.CustomEvent;
	import com.azwarriors.vo.FotoConvencionVO;
	import com.azwarriors.vo.FotosConvencionVO;
	import com.azwarriors.vo.ThumbSelectedVO;
	import com.azwarriors.vo.VO;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FotosConvencionThumbsSelector extends Sprite
	{
		public static const EVENT_THUMB_SELECTED:String = "onThumbSelectorSelected";
		public static const EVENT_THUMBS_READY:String = "onThumbSelectorReady";
		private var container:Sprite;
		private var data:FotosConvencionVO;
		private var thumbsArray:Array;
		public function FotosConvencionThumbsSelector()
		{
			
		}
		
		public function init(vo:FotosConvencionVO):void{
			container = new Sprite();
			addChild(container);
			data = vo;
			createThumbs();
		}
		
		private function createThumbs():void{
			thumbsArray = new Array();
			var xPos:int = 0;
			var yPos:int = 0;
			for (var i:int = 0; i < data.fotosConvencionArray.length; i++){
				//trace(i);
				var fotoConvencionVO:FotoConvencionVO = data.fotosConvencionArray[i];
				var thumbView:FotoConvencionThumbView = new FotoConvencionThumbView();
				thumbView.x = xPos;
				thumbView.y = yPos;
				container.addChild(thumbView);
				thumbView.addEventListener(FotoConvencionThumbView.EVENT_THUMB_CLICK, onThumbClickHandler);
				thumbsArray.push(thumbView);
				
				xPos += thumbView.width + 10;
				if(((i+1)%5) == 0){
					xPos = 0;
					yPos += thumbView.height + 6;
				}
			}
			dispatchEvent(new Event(EVENT_THUMBS_READY));
		}
		
		private function onThumbClickHandler(event:Event):void{
			for (var i:int = 0; i < thumbsArray.length; i++){
				if(event.target == thumbsArray[i]){
					var vo:ThumbSelectedVO = new ThumbSelectedVO();
					vo.id = i;
					dispatchEvent(new CustomEvent(FotosConvencionThumbsSelector.EVENT_THUMB_SELECTED, vo as VO));
					(thumbsArray[i] as FotoConvencionThumbView).selectThumb();
				}else{
					(thumbsArray[i] as FotoConvencionThumbView).deSelectThumb();
				}
			}
		}
		
		public function addThumbBitMap(image:Bitmap,index:int):void{
			(thumbsArray[index] as FotoConvencionThumbView).addBitMap(image);
		}
		
		public function selectThumb(idThumb:int):void{
			for (var i:int = 0; i < thumbsArray.length; i++){
				if(idThumb == i){
					(thumbsArray[i] as FotoConvencionThumbView).selectThumb();
				}else{
					(thumbsArray[i] as FotoConvencionThumbView).deSelectThumb();
				}
			}
		}
	}
}