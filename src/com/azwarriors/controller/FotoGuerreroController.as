package com.azwarriors.controller {
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import com.azwarriors.assets.mcPreloader_FC;
	import com.azwarriors.vo.FotoGuerreroVO;
	import com.azwarriors.view.FotoGuerreroView;
	import flash.events.Event;
	import com.azwarriors.model.MainModel;
	import flash.events.EventDispatcher;
	/**
	 * @author EstebanChavarria
	 */
	public class FotoGuerreroController extends EventDispatcher {
		public var view:Sprite;
		public var mainView:FotoGuerreroView;
		private var preloader:mcPreloader_FC;
		public function FotoGuerreroController(){
			view = new Sprite();
		}
		
		public function init():void{
			//trace("FotoGuerreroController - init");
			MainModel.getInstance().addEventListener(MainModel.MODEL_READY, onModelDataReady);
			MainModel.getInstance().loadFotoGuerreroVO();
			
			
			
			preloader = new mcPreloader_FC();
			preloader.alpha = 0;
			view.addChild(preloader);
			preloader.x = (1000 / 2);
			preloader.y = (600 / 2); 
			
			TweenLite.to(preloader,0.5,{alpha:1});
			
			//view = new FotoGuerreroView();
		}
		
		public function onModelDataReady(event:Event):void{
			TweenLite.to(preloader,0.5,{alpha:0, onComplete:removePreloader});
			
			MainModel.getInstance().removeEventListener(MainModel.MODEL_READY, onModelDataReady);
			mainView = new FotoGuerreroView();	
			view.addChild(mainView);
			mainView.init(MainModel.getInstance().data as FotoGuerreroVO);
			
			
			//trace("FotoGuerreroController - onModelDataReady");
		}
		
		private function removePreloader():void{
			view.removeChild(preloader);
			preloader = null;
		}

		public function stopView():void {
			mainView.stopSong();
		}
		
	}
}
