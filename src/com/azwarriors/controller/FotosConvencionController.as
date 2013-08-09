package com.azwarriors.controller
{
	import com.azwarriors.assets.mcPreloader_FC;
	import com.azwarriors.events.CustomEvent;
	import com.azwarriors.model.MainModel;
	import com.azwarriors.view.FotosConvencionView;
	import com.azwarriors.vo.FotoConvencionVO;
	import com.azwarriors.vo.FotosConvencionVO;
	import com.azwarriors.vo.ThumbSelectedVO;
	import com.greensock.TweenLite;
	
	import dev.home.FotoConvencion;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	public class FotosConvencionController extends EventDispatcher
	{
		public var view:Sprite;
		public var mainView:FotosConvencionView;
		public var fotosConvecionVO:FotosConvencionVO;
		
		private var preloader:mcPreloader_FC;
		
		private var thumbImageLoaded:int;
		
		public function FotosConvencionController()
		{
			view = new Sprite();
			trace("FotosConvencionController - Created");	
		}
		
		public function init():void{
			
			preloader = new mcPreloader_FC();
			preloader.alpha = 0;
			view.addChild(preloader);
			preloader.x = 1000/2;
			preloader.y = 600/2;
			TweenLite.to(preloader,0.5,{alpha:1});
			
			MainModel.getInstance().addEventListener(MainModel.MODEL_READY,onModelReadyHandler);
			MainModel.getInstance().loadFotosConvencionVO();
			mainView = new FotosConvencionView();
			mainView.addEventListener(FotosConvencionView.EVENT_THUMBS_READY,onThumbsReady);
		}
		
		private function onModelReadyHandler(event:Event):void{
			TweenLite.to(preloader,0.5,{alpha:0,onComplete:removePreloader});
			MainModel.getInstance().removeEventListener(MainModel.MODEL_READY,onModelReadyHandler);
			view.addChild(mainView);
			fotosConvecionVO = MainModel.getInstance().data as FotosConvencionVO;
			mainView.init(MainModel.getInstance().data as FotosConvencionVO);
			mainView.addEventListener(FotosConvencionView.EVENT_THUMB_SELECTED,onThumbSelected);
		}
		
		private function onThumbsReady(event:Event):void{
			mainView.removeEventListener(FotosConvencionView.EVENT_THUMBS_READY,onThumbsReady);
			thumbImageLoaded = 0;
			MainModel.getInstance().addEventListener(MainModel.MODEL_THUMB_READY, onThumbImageLoaded);
			loadThumbImage(thumbImageLoaded);
		}
		
		private function onThumbImageLoaded(event:Event):void{
			var image:Bitmap = MainModel.getInstance().thumbImage;
			//trace("FotosConvencionController - onThumbImageLoaded - image: "+image);
			
			mainView.addThumbImageOnSelector(MainModel.getInstance().thumbImage,thumbImageLoaded);
			thumbImageLoaded++;
			if(thumbImageLoaded <= fotosConvecionVO.fotosConvencionArray.length-1){
				loadThumbImage(thumbImageLoaded);
			}
		}
		
		private function loadThumbImage(thumbImageId:int):void{
			MainModel.getInstance().loadThumbImage((fotosConvecionVO.fotosConvencionArray[thumbImageId] as FotoConvencionVO).thumbUrl);
			
		}
		
		private function onThumbSelected(event:CustomEvent):void{
			MainModel.getInstance().addEventListener(MainModel.MODEL_READY,onModelImageReadyHandler);
			var imageUrl:String = (fotosConvecionVO.fotosConvencionArray[(event.data as ThumbSelectedVO).id] as FotoConvencionVO).imageUrl;
			MainModel.getInstance().loadImage(imageUrl);
		}
		
		private function onModelImageReadyHandler(event:Event):void{
			MainModel.getInstance().removeEventListener(MainModel.MODEL_READY,onModelImageReadyHandler);
			mainView.presentImageOnImageDisplayer(MainModel.getInstance().image);
		}
		
		private function removePreloader():void{
			view.removeChild(preloader);
			preloader = null;
		}
	}
}