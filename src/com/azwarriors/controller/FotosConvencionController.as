package com.azwarriors.controller
{
	import com.greensock.TweenLite;
	import com.azwarriors.assets.mcPreloader_FC;
	import flash.display.Sprite;
	import com.azwarriors.vo.FotoConvencionVO;
	import dev.home.FotoConvencion;
	import com.azwarriors.model.MainModel;
	import com.azwarriors.view.FotosConvencionView;
	import com.azwarriors.vo.FotosConvencionVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class FotosConvencionController extends EventDispatcher
	{
		public var view:Sprite;
		public var mainView:FotosConvencionView;
		
		private var preloader:mcPreloader_FC;
		
		public function FotosConvencionController()
		{
			view = new Sprite();
			trace("FotosConvencionController - Created");	
		}
		
		public function init():void{
			
			preloader = new mcPreloader_FC();
			preloader.alpha = 0;
			view.addChild(preloader);
			preloader.x = view.stage.stageWidth/2;
			preloader.y = view.stage.stageHeight/2;
			TweenLite.to(preloader,0.5,{alpha:1});
			
			MainModel.getInstance().addEventListener(MainModel.MODEL_READY,onModelReadyHandler);
			MainModel.getInstance().loadFotosConvencionVO();
			mainView = new FotosConvencionView();
		}
		
		private function onModelReadyHandler(event:Event):void{
			TweenLite.to(preloader,0.5,{alpha:0,onComplete:removePreloader});
			MainModel.getInstance().removeEventListener(MainModel.MODEL_READY,onModelReadyHandler);
			view.addChild(mainView);
			mainView.init(MainModel.getInstance().data as FotosConvencionVO);
			
		}
		
		private function removePreloader():void{
			view.removeChild(preloader);
			preloader = null;
		}
	}
}