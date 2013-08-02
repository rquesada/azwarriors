package com.azwarriors.view
{
	import flash.events.Event;
	import com.greensock.TweenLite;
	import com.azwarriors.vo.ThumbSelectedVO;
	import com.azwarriors.events.CustomEvent;
	import com.azwarriors.assets.mcFotosConvencionTitle_FC;
	import com.azwarriors.vo.FotoConvencionVO;
	import com.azwarriors.vo.FotosConvencionVO;
	
	import flash.display.Sprite;
	
	public class FotosConvencionView extends Sprite
	{
		private var fotosConvencion:FotosConvencionVO;
		private var imageDisplayer:FotosConvencionImageDisplayer;
		private var thumbsSelector:FotosConvencionThumbsSelector;
		private var fotosConvencionTitle:mcFotosConvencionTitle_FC;
		private var thumbSelectedId:int;
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
			//thumbsSelector.x = 40;
			//thumbsSelector.y = 155;
			//addChild(thumbsSelector);
			thumbSelectedId = 0;
			imageDisplayer.totalImages = fotosConvencion.fotosConvencionArray.length;
		}

		private function onThumbsReady(event:Event):void{
			var scroll:Scroll = new Scroll();
			scroll.init(830, 350, thumbsSelector);	
			addChild(scroll);
			scroll.x = 40;
			scroll.y = 155;
		}

		private function onThumbSelected(event:CustomEvent):void{
			trace("FCView - thumbSelected: " + (event.data as ThumbSelectedVO).id);
			thumbSelectedId = (event.data as ThumbSelectedVO).id;
			if(!contains(imageDisplayer)){
				imageDisplayer.alpha = 0;
				addChild(imageDisplayer);
				TweenLite.to(imageDisplayer, 0.5, {alpha:1});
			}
			imageDisplayer.presentImage((fotosConvencion.fotosConvencionArray[(event.data as ThumbSelectedVO).id] as FotoConvencionVO).image);
			imageDisplayer.setCurrentImageText(thumbSelectedId+1);		
		}

		private function presentPreviousImageHandler(event:Event):void {
			if(thumbSelectedId > 0){
				thumbSelectedId--;
			}else{
				return;
			}
			thumbsSelector.selectThumb(thumbSelectedId);
			imageDisplayer.presentImage((fotosConvencion.fotosConvencionArray[thumbSelectedId] as FotoConvencionVO).image);
			imageDisplayer.setCurrentImageText(thumbSelectedId+1);	
		}
		
		private function presentNextImageHandler(event:Event):void {
			if(thumbSelectedId < fotosConvencion.fotosConvencionArray.length-1){
				thumbSelectedId++;
			}else{
				return;
			}
			thumbsSelector.selectThumb(thumbSelectedId);
			imageDisplayer.presentImage((fotosConvencion.fotosConvencionArray[thumbSelectedId] as FotoConvencionVO).image);	
			imageDisplayer.setCurrentImageText(thumbSelectedId+1);
		}
	}
}