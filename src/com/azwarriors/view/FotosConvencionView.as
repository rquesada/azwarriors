package com.azwarriors.view
{
	import com.azwarriors.assets.mcArribaButton_FC;
	import com.azwarriors.assets.mcArribaText_FC;
	import com.azwarriors.assets.mcFotosConvencionTitle_FC;
	import com.azwarriors.assets.mcMaskFotoGuerrero_FC;
	import com.azwarriors.events.CustomEvent;
	import com.azwarriors.vo.FotoConvencionVO;
	import com.azwarriors.vo.FotosConvencionVO;
	import com.azwarriors.vo.ThumbSelectedVO;
	import com.azwarriors.vo.VO;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class FotosConvencionView extends Sprite
	{
		public static const EVENT_THUMB_SELECTED:String = "onThumbSelectedFotoConvencionView";
		
		private var fotosConvencion:FotosConvencionVO;
		private var imageDisplayer:FotosConvencionImageDisplayer;
		private var thumbsSelector:FotosConvencionThumbsSelector;
		private var fotosConvencionTitle:mcFotosConvencionTitle_FC;
		private var thumbSelectedId:int;
		
		private var arribaBtn:mcArribaButton_FC;
		private var arribaText:mcArribaText_FC;
		private var arribaTextMask:Sprite;
		
		private var scroll:Scroll;
		
		public function FotosConvencionView()
		{
			imageDisplayer = new FotosConvencionImageDisplayer();
			imageDisplayer.init();
			imageDisplayer.y = 0;
			imageDisplayer.x = 0;
			imageDisplayer.addEventListener(FotosConvencionImageDisplayer.EVENT_NEXT_IMAGE, presentNextImageHandler);
			imageDisplayer.addEventListener(FotosConvencionImageDisplayer.EVENT_PREVIOUS_IMAGE, presentPreviousImageHandler);
			//addChild(imageDisplayer);
		}
		
		public function init(vo:FotosConvencionVO):void {
			fotosConvencionTitle  = new mcFotosConvencionTitle_FC();
			fotosConvencionTitle.y = 56;
			fotosConvencionTitle.x = 187;
			addChild(fotosConvencionTitle);
			
			fotosConvencion = vo;
			//imageDisplayer.presentImage((fotosConvencion.fotosConvencionArray[0] as FotoConvencionVO).image);
			thumbsSelector = new FotosConvencionThumbsSelector();
			thumbsSelector.addEventListener(FotosConvencionThumbsSelector.EVENT_THUMB_SELECTED, onThumbSelected);
			thumbsSelector.addEventListener(FotosConvencionThumbsSelector.EVENT_THUMBS_READY, onThumbsReady);
			thumbsSelector.init(vo);
			//thumbsSelector.x = 720;
			thumbsSelector.x = 40;
			//thumbsSelector.y = 155;
			//addChild(thumbsSelector);
			thumbSelectedId = 0;
			imageDisplayer.totalImages = fotosConvencion.fotosConvencionArray.length;
			
			arribaText = new mcArribaText_FC();
			
			arribaBtn = new mcArribaButton_FC();
			arribaBtn.y = 500;
			arribaBtn.addEventListener(MouseEvent.ROLL_OVER, onArribaBtnRollOver);
			arribaBtn.addEventListener(MouseEvent.ROLL_OUT, onArribaBtnRollOut);
			arribaBtn.addEventListener(MouseEvent.CLICK, onArribaBtnClickHandler);
			arribaText.y = arribaBtn.y - arribaText.height - 5;
			
			arribaTextMask = new Sprite();
			arribaTextMask.graphics.beginFill(0x000000);
			arribaTextMask.graphics.drawRect(0, 0, arribaText.width, arribaText.height);
			arribaTextMask.graphics.endFill();
			arribaText.x = 0;
			arribaTextMask.x = arribaText.x - arribaTextMask.width;
			arribaTextMask.y = arribaText.y;
			
			arribaText.mask = arribaTextMask;
			
			
			addChild(arribaText);
			addChild(arribaTextMask);
			addChild(arribaBtn);
		}

		private function onArribaBtnClickHandler(event:Event):void{
			scroll.updatePosition(0);
		}
		
		private function onArribaBtnRollOut(event : MouseEvent) : void {
			//trace("onArribaBtnRollOut");
			TweenLite.to(arribaTextMask,0.3, {x:(arribaText.x - arribaTextMask.width - 30)});
		}

		private function onArribaBtnRollOver(event : MouseEvent) : void {
			TweenLite.to(arribaTextMask,0.3, {x:arribaText.x });
		}

		private function onThumbsReady(event:Event):void{
			scroll = new Scroll();
			addChild(scroll);
			scroll.init(870, 350, thumbsSelector);	
			
			scroll.x = 40;
			scroll.y = 155;
		}

		private function onThumbSelected(event:CustomEvent):void{
			trace("FCView - thumbSelected: " + (event.data as ThumbSelectedVO).id);
			thumbSelectedId = (event.data as ThumbSelectedVO).id;
			dispatchEvent(new CustomEvent(EVENT_THUMB_SELECTED,event.data));
			/*if(!contains(imageDisplayer)){
				imageDisplayer.alpha = 0;
				addChild(imageDisplayer);
				TweenLite.to(imageDisplayer, 0.5, {alpha:1});
			}
			imageDisplayer.presentImage((fotosConvencion.fotosConvencionArray[(event.data as ThumbSelectedVO).id] as FotoConvencionVO).image);
			imageDisplayer.setCurrentImageText(thumbSelectedId+1);*/		
		}
		
		public function presentImageOnImageDisplayer(image:Bitmap):void{
			if(!contains(imageDisplayer)){
				imageDisplayer.alpha = 0;
				addChild(imageDisplayer);
				TweenLite.to(imageDisplayer, 0.5, {alpha:1});
			}
			imageDisplayer.presentImage(image);
			imageDisplayer.setCurrentImageText(thumbSelectedId+1);
		}
		
		private function presentPreviousImageHandler(event:Event):void {
			if(thumbSelectedId > 0){
				thumbSelectedId--;
			}else{
				return;
			}
			thumbsSelector.selectThumb(thumbSelectedId);
			//imageDisplayer.presentImage((fotosConvencion.fotosConvencionArray[thumbSelectedId] as FotoConvencionVO).image);
			var vo:ThumbSelectedVO = new ThumbSelectedVO();
			vo.id = thumbSelectedId;
			dispatchEvent(new CustomEvent(EVENT_THUMB_SELECTED,vo as VO));
			imageDisplayer.setCurrentImageText(thumbSelectedId+1);	
		}
		
		private function presentNextImageHandler(event:Event):void {
			if(thumbSelectedId < fotosConvencion.fotosConvencionArray.length-1){
				thumbSelectedId++;
			}else{
				return;
			}
			thumbsSelector.selectThumb(thumbSelectedId);
			//imageDisplayer.presentImage((fotosConvencion.fotosConvencionArray[thumbSelectedId] as FotoConvencionVO).image);
			var vo:ThumbSelectedVO = new ThumbSelectedVO();
			vo.id = thumbSelectedId;
			dispatchEvent(new CustomEvent(EVENT_THUMB_SELECTED,vo as VO));
			imageDisplayer.setCurrentImageText(thumbSelectedId+1);
		}
	}
}